# **Introduction**
Dear Candidate,

Thank you for your interest in joining our team and for taking on this assignment. We appreciate your time and effort in working on this challenge. This task will help us evaluate your skills in building a scalable and maintainable data processing pipeline while adhering to business requirements and ensuring data quality.

We look forward to seeing your approach and reviewing your solution. Your work will give us insight into your problem-solving and technical abilities.

Below, you will find the assignment description and requirements. If you have any questions, please don’t hesitate to contact us. Good luck!


# **Assignment Description**


## **Overview**

At Datenna, we integrate diverse types of data from multiple sources to deliver high-quality outputs on our platform.

The procurement data you’ll be working with is a critical component of this mission. Agencies and Regulators rely on procurement data to make informed decisions about suppliers and ensure compliance with trade regulations.
By processing and standardizing this data, you’ll be helping our clients gain actionable insights that drive strategic decision-making.

To enable this and many other usecases, we have a data processing pipeline that consists of three main steps:

1. **Scraping** - Collecting raw data from various sources.
2. **Processing** - Transforming raw data into structured, high-quality datasets.
3. **Serving** - Delivering the processed data to consumers in a usable format.

To ensure scalability and maintain our high-quality standards as we add new sources, we use **Data Contracts**. These contracts define the expectations for data at both the **ingestion side** (Scraping → Processing) and the **consumer side** (Processing → Serving).

This assignment will challenge you to define and implement a Data Contract for processing procurement data. You’ll also build the necessary pipeline components to ensure that the data adheres to these contracts and meets quality standards.


## **Input**

* **Data Contracts**: A sample Data Contract defining the expectations for the input data.
* **Dataset**: A procurement dataset consisting of multiple sources
* **Expected Output Requirements**: A description of the expected output (e.g. business rules, data filtering rules, expected formatting, etc)

Note that the input data and files are entirely mocked data, some inconsistencies may happen.

## **Primary Task**

* **Draft a Data Contract for the Output**:
  * Define what the processed data should look like, based on the provided dataset and expected output requirements.
* **Build a dbt Pipeline**:
  * Transform the raw data into processed data using the Dataset, Data Contract, and Expected Output Requirements.
  * Ensure high-quality data output in line with the agreements specified in the contracts.
* **Design a CI/CD Pipeline**:
  * Propose a design for a continuous integration and deployment pipeline to automate testing and deployment.

## **Key Requirements**

* **Explainability**: Ensure the results are interpretable and that it is clear how the system arrived at its outcomes.
* **Maintainability**: Design a pipeline that is easy to maintain and scalable to accommodate new data sources.
* **Documentation**: Provide clear and comprehensive documentation for your code and processes.
* **Usability and Collaboration**: Ensure the project is runnable by other developers and that the documentation clearly explains how to set it up and use it.


## **Bonus Challenge**

* CI/CD implementation based on the proposed design.
* Track and log significant decisions made during development for improved explainability using a Decision Tracking System.


## **Deliverables**

* **Data Contract File**
* **Source Code for the dbt Project**
* **Documentation**: How to run the solution, additional documentation explaining the approach and design decisions.


## **Evaluation Criteria**

* **Correctness and Effectiveness**: Does the solution meet the requirements and produce the expected results?
* **Performance and Scalability**: Is the solution optimized for large datasets and scalable to new data sources?
* **Creativity and Depth**: How innovative and thoughtful is the approach?
* **Code Quality and Organization**: Is the code well-written, modular, and organized?
* **Documentation**: Is the documentation clear, thorough, and helpful?


## **Submission Guidelines**

* Share the repository containing your solution
* Include a README file with setup instructions and any additional notes
* Submit your solution one week (seven days) after receiving this email


## **Questions and Support**

For any clarifications or questions regarding the assignment, please contact [paulo.filho@datenna.com](mailto:paulo.filho@datenna.com).
