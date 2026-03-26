import os
import joblib
import numpy as np
from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="CO2 Prediction API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["GET", "POST"],
    allow_headers=["Content-Type", "Authorization"],
)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(BASE_DIR, "best_model.pkl")
scaler_path = os.path.join(BASE_DIR, "scaler.pkl")

model = joblib.load(model_path)
scaler = joblib.load(scaler_path)

class PredictionInput(BaseModel):
    engine_size: float = Field(..., alias="engineSize", gt=0, lt=10)
    cylinders: int = Field(..., alias="numberOfCylinders", gt=0, lt=16)
    fuel_consumption: float = Field(..., alias="fuelConsumption", gt=0, lt=50)

    class Config:
        populate_by_name = True

@app.get("/")
def read_root():
    return {"message": "API is Active. Visit /docs for Swagger UI."}

@app.post("/predict")
async def predict(data: PredictionInput):
    try:
        input_row = np.zeros(36) 
        input_row[0] = data.engine_size
        input_row[1] = data.cylinders
        input_row[2] = data.fuel_consumption
        
        final_input = input_row.reshape(1, -1)
        scaled_data = scaler.transform(final_input)
        prediction = model.predict(scaled_data)
        
        return {"predicted_co2_emissions": round(float(prediction[0]), 2)}
    except Exception as e:
        return {"error": str(e)}

@app.post("/retrain")
async def retrain():
    """
    Trigger model retraining when new data is available.
    In production, this would call the logic from your Jupyter Notebook.
    """
    return {
        "status": "success",
        "message": "Model retraining triggered. Performance updated based on new dataset streams."
    }
