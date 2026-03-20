# Automotive Environmental Compliance: CO2 Emissions Prediction

# Mission Statement
The mission is to support environmental impact analysis by accurately predicting vehicle CO2 emissions based on technical specifications. This tool allows manufacturers to audit prototype designs for environmental compliance before physical production.

# Description and Source of Data
- Problem: Reducing carbon footprints requires instant data feedback during vehicle design.
- Data Source: This project uses the CO2 Emissions Canada dataset sourced from Kaggle.
- Dataset Characteristics: It is a rich dataset containing 7,385 records with a variety of features including Engine Size, Cylinders, Fuel Type, and multiple Fuel Consumption metrics.

# Repository Structure
linear_regression_model/
├── summative/
│   ├── linear_regression/
│   │   └── multivariate.ipynb (Includes Visualizations, SGD Optimization, and Comparisons)
│   ├── API/                     
│   └── FlutterApp/              

# How to Run
1. Install dependencies: `pip install pandas numpy matplotlib seaborn scikit-learn joblib`
2. Ensure `CO2 Emissions_Canada.csv` is in the same directory as the notebook.
3. Run `multivariate.ipynb` to train models and generate `best_model.pkl`.