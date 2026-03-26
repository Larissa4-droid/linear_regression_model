import os
import joblib
import numpy as np
from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="CO2 Prediction API")

# 1. CORS Middleware (Essential for Chrome/Web)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 2. Define BASE_DIR and load files using absolute paths
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(BASE_DIR, "best_model.pkl")
scaler_path = os.path.join(BASE_DIR, "scaler.pkl")

model = joblib.load(model_path)
scaler = joblib.load(scaler_path)

# 3. Input Schema
class PredictionInput(BaseModel):
    engine_size: float
    cylinders: int
    fuel_consumption: float

@app.get("/")
def read_root():
    return {"message": "CO2 Prediction API is active and ready for 36-feature dummy input."}

# 4. The Prediction Logic
@app.post("/predict")
async def predict(data: PredictionInput):
    try:
        # Create a row of 36 zeros (matching your notebook's One-Hot encoded shape)
        input_row = np.zeros(36) 
        
        # Fill the first 3 spots with your app's numerical data
        input_row[0] = data.engine_size
        input_row[1] = data.cylinders
        input_row[2] = data.fuel_consumption
        
        # Reshape to (1, 36) as expected by the scaler
        final_input = input_row.reshape(1, -1)

        # Scale and Predict
        scaled_data = scaler.transform(final_input)
        prediction = model.predict(scaled_data)
        
        return {"predicted_co2_emissions": round(float(prediction[0]), 2)}
    
    except Exception as e:
        return {"error": str(e)}

