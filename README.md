# Automotive Environmental Compliance: CO2 Emissions Prediction

# Mission Statement
The mission is to support environmental impact analysis by accurately predicting vehicle CO2 emissions based on technical specifications. This tool allows manufacturers to audit prototype designs for environmental compliance before physical production, addressing the critical need for data feedback in sustainable vehicle engineering.

# Description and Source of Data
Problem: Reducing carbon footprints requires instant data feedback during the vehicle design phase.

Source: This project uses the CO2 Emissions Canada dataset sourced from Kaggle.

Dataset Characteristics: It is a rich dataset containing 7,385 records with a variety of features including Engine Size, Cylinders, Fuel Type, and multiple Fuel Consumption metrics.

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

Navigate to the API folder: cd summative/API.

Install dependencies: pip install -r requirements.txt.

Run the server: uvicorn prediction:app --reload.

Access Swagger UI at https://linearregressionmodel-production.up.railway.app/docs 

2. Mobile App (Flutter)

Ensure the Flutter SDK is installed and an emulator is running.

Navigate to the app folder: cd summative/FlutterApp/co2.

Install packages: flutter pub get.

Launch the app: flutter run.

3. Notebook (Training)

Open multivariate.ipynb in Jupyter or Google Colab.

Ensure CO2 Emissions_Canada.csv is in the same directory.

Execute cells to view visualizations (Heatmaps, Scatter plots) and compare Linear Regression, Decision Trees, and Random Forest models.