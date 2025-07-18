# MLOPS_Hotel_cancellation

## Project Overview

This project is an end-to-end MLOps pipeline for predicting hotel reservation cancellations. It covers data ingestion, preprocessing, model training, evaluation, experiment tracking, deployment as a web app, and CI/CD automation using Jenkins and Google Cloud Platform (GCP).

---

## Table of Contents
- [Project Overview](#project-overview)
- [Directory Structure](#directory-structure)
- [Setup & Installation](#setup--installation)
- [Configuration](#configuration)
- [Pipeline Workflow](#pipeline-workflow)
- [Web Application](#web-application)
- [CI/CD & Deployment](#cicd--deployment)
- [Logging & Artifacts](#logging--artifacts)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

---

## Directory Structure

```
├── app.py                  # Flask web app for prediction
├── Dockerfile              # Docker containerization
├── Jenkinsfile             # Jenkins CI/CD pipeline
├── requirements.txt        # Python dependencies
├── setup.py                # Project packaging
├── README.md               # Project documentation
├── src/                    # Core ML pipeline modules
│   ├── data_ingestion.py
│   ├── data_preprocessing.py
│   ├── model_training.py
│   ├── logger.py
│   ├── custom_exception.py
│   └── __init__.py
├── pipeline/               # Pipeline orchestration
│   └── training_pipeline.py
├── config/                 # Configuration files
│   ├── config.yml
│   ├── model_params.py
│   ├── paths_config.py
│   └── __init__.py
├── utils/                  # Utility functions
│   ├── common_funtions.py
│   └── __init__.py
├── notebook/               # Jupyter notebooks (exploration, EDA)
│   └── notebook.ipynb
├── templates/              # HTML templates for Flask
│   └── index.html
├── static/                 # Static files (CSS)
│   └── style.css
├── artifacts/              # Data and model artifacts
│   ├── raw/
│   ├── processed/
│   └── models/
├── mlruns/                 # MLflow experiment tracking
├── logs/                   # Log files
├── custom_jenkins/         # Custom Jenkins scripts (if any)
│   └── Dockerfile
├── MLOPS_PROJECT_1.egg-info/ # Packaging metadata
└── venv/                   # Python virtual environment (not tracked)
```

---

## Setup & Installation

### 1. Clone the Repository
```bash
git clone https://github.com/KEERTHIKUMAR517/MLOPS_Hotel_cancellation.git
cd MLOPS_Hotel_cancellation
```

### 2. Create and Activate Virtual Environment
```bash
python -m venv venv
# On Windows:
venv\Scripts\activate
# On Unix/Mac:
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install --upgrade pip
pip install -e .
```

### 4. Configuration
Edit `config/config.yml` to set GCP bucket, data columns, and processing parameters as needed.

---

## Configuration

- **config/config.yml**: Main configuration for data ingestion and preprocessing.
- **config/model_params.py**: Model hyperparameters for LightGBM and RandomizedSearchCV.
- **config/paths_config.py**: Centralized paths for data and model artifacts.

---

## Pipeline Workflow

The pipeline is orchestrated in `pipeline/training_pipeline.py` and consists of:

1. **Data Ingestion** (`src/data_ingestion.py`)
   - Downloads raw data from a GCP bucket (set in `config.yml`).
   - Splits data into train/test sets and saves to `artifacts/raw/`.

2. **Data Preprocessing** (`src/data_preprocessing.py`)
   - Drops unnecessary columns, handles duplicates.
   - Label encodes categorical features.
   - Handles skewness in numerical features.
   - Balances data using SMOTE.
   - Selects top features using RandomForest importance.
   - Saves processed data to `artifacts/processed/`.

3. **Model Training & Evaluation** (`src/model_training.py`)
   - Trains a LightGBM classifier with hyperparameter tuning.
   - Evaluates using accuracy, precision, recall, F1-score.
   - Logs metrics and artifacts to MLflow (`mlruns/`).
   - Saves the trained model to `artifacts/models/`.

4. **Experiment Tracking**
   - MLflow is used for tracking experiments, parameters, and metrics.

---

## Web Application

- **app.py**: Flask app for serving predictions via a web interface.
- **templates/index.html**: User form for inputting reservation details and displaying predictions.
- **static/style.css**: Responsive, modern styling for the web interface.

### Running Locally
```bash
python app.py
# Visit http://localhost:5000
```

---

## CI/CD & Deployment

### Jenkins Pipeline (`Jenkinsfile`)
- **Stages:**
  1. Clone repo
  2. Set up virtualenv and install dependencies
  3. Build and push Docker image to Google Container Registry (GCR)
  4. Deploy to Google Cloud Run
- **Secrets:** Uses Jenkins credentials for GitHub and GCP service account.

### Docker
- **Dockerfile**: Builds a container with all dependencies, runs the training pipeline, and starts the Flask app.

#### Build & Run Docker Locally
```bash
docker build -t hotel-cancellation-app .
docker run -p 5000:5000 hotel-cancellation-app
```

### Google Cloud Run
- Deploys the Docker image as a managed service, scalable and accessible via HTTPS.

---

## Logging & Artifacts
- **logs/**: Stores log files for pipeline runs and app usage.
- **artifacts/**: Stores raw, processed data, and trained models.
- **mlruns/**: MLflow experiment tracking (metrics, params, models).

---

## Usage

### End-to-End Pipeline
Run the full pipeline (data ingestion, preprocessing, training):
```bash
python pipeline/training_pipeline.py
```

### Web App
After training, serve predictions via the Flask app:
```bash
python app.py
```

### MLflow UI
To view experiment tracking:
```bash
mlflow ui
# Visit http://localhost:5000 (default)
```

---

## Contributing
1. Fork the repo and create your branch.
2. Make your changes and add tests if needed.
3. Submit a pull request.

---

## License
This project is licensed under the MIT License.