# Automotive Environmental Compliance: CO2 Emissions Prediction

# Mission Statement
Predict vehicle CO2 emissions using engine and fuel consumption features to support environmental impact analysis. This tool allows for auditing prototype designs for environmental 
compliance before physical production, addressing the need for instant data feedback in sustainable vehicle design.

# Description and Source of Data
Problem: Instant feedback on carbon footprints is required during the vehicle design phase to meet global emissions standards.
Source: CO2 Emissions Canada Dataset (Kaggle).
Characteristics: 7,385 records featuring Engine Size, Cylinders, Fuel Type, and Consumption metrics.

# Public API & Video Demo
Public API (Swagger UI): https://linearregressionmodel-production.up.railway.app/docs
Video Demo (YouTube):

# Repository Structure
linear_regression_model/
├── summative/
│   ├── linear_regression/
│   │   └── multivariate.ipynb (Visualizations, SGD, & Model Training)
│   ├── API/
│   │   ├── prediction.py      (FastAPI + Retraining Endpoint)
│   │   ├── best_model.pkl     (Trained Random Forest Model)
│   │   ├── scaler.pkl         (Feature Standardizer)
│   │   └── requirements.txt   
│   └── FlutterApp/
│       └── co2/               (Flutter Mobile Application)
└── README.md              

# How to Run
1. API (FastAPI)
Navigate to summative/API.
Install requirements: pip install -r requirements.txt.
Run locally: uvicorn prediction:app --reload.

2. Mobile App (Flutter)
Ensure Flutter is installed (flutter doctor).
Navigate to summative/FlutterApp/co2.
Fetch packages: flutter pub get.
Launch an Android Emulator or iOS Simulator.
Run: flutter run.

3. Notebook (Training)
Ensure CO2 Emissions_Canada.csv is in the linear_regression folder.
Run multivariate.ipynb to visualize data and see the comparison between Linear Regression, Decision Trees, and Random Forest.