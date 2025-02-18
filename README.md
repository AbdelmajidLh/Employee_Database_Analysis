# R Project: Employee Database Analysis

# Hello, c'est [Abdelmajid][linkedin] 👋
[![My Website](https://img.shields.io/website?style=for-the-badge&url=https%3A%2F%2Fabdelmajidlh.github.io%2FePortfolio%2F)][website] [![LinkedIn](https://img.shields.io/badge/LinkedIn-Abdelmajid%20EL%20HOU-blue?style=for-the-badge&logo=linkedin&logoColor=blue)][linkedin]

[website]: https://abdelmajidlh.github.io/ePortfolio/
[linkedin]: https://www.linkedin.com/in/aelhou/

## 📌 Project Overview
This project aims to analyze employee data stored in CSV files and process it using an SQLite database. The workflow involves:

1. **Data Ingestion**: Reading CSV files containing employee records.
2. **Database Storage**: Storing structured data in an SQLite database.
3. **Data Analysis**: Performing exploratory data analysis (EDA) and visualizations.
4. **Results Storage**: Saving insights and aggregations back to the database.
5. **Automation & Deployment**: Ensuring an automated execution with Docker and `renv` for dependency management.

## 📁 Project Structure
```
R_project/
│-- data/                     # Directory for input CSV files
│-- logs/                     # Directory for logs
│-- scripts/                  # Directory for modular scripts
│   │-- load_data.R           # Reads CSV files
│   │-- store_data.R          # Stores data in SQLite
│   │-- read_database.R       # Reads data from SQLite
│   │-- exploratory_analysis.R# Exploratory Data Analysis
│   │-- store_results.R       # Saves results in SQLite
│-- utils/
│   │-- packages.R            # Manages package installation
│-- tests/                    # Directory for unit tests
│-- renv/                     # Virtual environment managed by renv
│-- renv.lock                 # Lockfile for reproducibility
│-- main.R                    # Main script orchestrating execution
│-- Dockerfile                # Docker configuration for deployment
│-- .gitignore                # Ignore unnecessary files in Git
│-- README.md                 # Project documentation
```

## Getting Started
### **1. Clone the repository**
```sh
git clone https://github.com/your-repo-name.git
cd R_project
```

### **2. Set up dependencies**
Ensure `renv` is installed and restore the environment:
```r
install.packages("renv")
renv::restore()
```

### **3. Run the Project**
Execute the main script to run the full pipeline:
```r
source("main.R")
```

### **4. Run Tests**
To validate functionality, execute:
```r
source("tests.R")
```

## 📦 Docker Deployment
To run the project in a containerized environment:
1. **Build the Docker image**
   ```sh
   docker build -t r_project .
   ```
2. **Run the container**
   ```sh
   docker run --rm r_project
   ```

## 📊 Data Analysis
### **Exploratory Data Analysis (EDA)**
- Salary distribution visualized in a histogram.
- Employee statistics grouped by department and job title.

### **Example Queries**
1. **List employee salaries**:
   ```sql
   SELECT emp_no, salary FROM salaries ORDER BY emp_no;
   ```
2. **Find employees hired in 1986**:
   ```sql
   SELECT first_name, last_name, hire_date FROM employees WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
   ```

## 🔥 Key Features
- **Automated package management** with `packages.R`
- **Virtual environment** with `renv`
- **Logging system** for tracking execution
- **Modular code structure** for maintainability
- **Docker support** for easy deployment

## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing
Feel free to submit issues, fork the repo, and make pull requests. Contributions are welcome!
