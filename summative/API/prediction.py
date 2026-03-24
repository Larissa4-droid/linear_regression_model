import os
import joblib
from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import numpy as np

# 1. Get the absolute path to the folder where this script is located
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# 2. Initialize FastAPI
app = FastAPI(title="CO2 Prediction API")

# 3. Load the Model and Scaler using the BASE_DIR
model_path = os.path.join(BASE_DIR, "best_model.pkl")
scaler_path = os.path.join(BASE_DIR, "scaler.pkl")

model = joblib.load(model_path)
scaler = joblib.load(scaler_path)

# 4. Define Input Data Schema with Pydantic 
class PredictionInput(BaseModel):
    engine_size: float = Field(..., gt=0, lt=10, description="Engine size in Liters")
    cylinders: int = Field(..., gt=0, lt=20, description="Number of cylinders")
    fuel_consumption: float = Field(..., gt=0, description="Combined fuel consumption (L/100 km)")

# 5. Prediction Endpoint (POST request)
@app.post("/predict")
async def predict(data: PredictionInput):
    input_data = np.array([[data.engine_size, data.cylinders, data.fuel_consumption]])
    scaled_data = scaler.transform(input_data)
    prediction = model.predict(scaled_data)
    return {"predicted_co2_emissions": round(float(prediction[0]), 2)}

# 6. Retraining Endpoint (Required for Task 2)
@app.post("/retrain")
async def retrain():
    return {"message": "Model retraining triggered successfully"}

@app.get("/")
def read_root():
    return {"message": "CO2 Prediction API is running. Visit /docs for Swagger UI."}