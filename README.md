<a name="readme-top"></a>


<div align="center">

  <h3><b>Vet Clinic DataBase README Template</b></h3>

</div>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 [Vet clinic database] <a name="about-project"></a>

**[Vet clinic database]**. In this project, I use a relational database to create the data structure for a vet clinic. I start with one table, and step by step, create a complete database with data about:  animals, animals' owners, clinic employees, and visits. Apart from building data structure, I also run SQL queries to answer specific questions.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>


<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

This repository includes files with plain SQL that can be used to recreate a database:

- Use [schema.sql](./schema.sql) to create all tables.
- Use [data.sql](./data.sql) to populate tables with sample data.
- Check [queries.sql](./queries.sql) for examples of queries that can be run on a newly created database. **Important note: this file might include queries that make changes in the database (e.g., remove records). Use them responsibly!**


### Setup
- install postgreSQL on your machine 
- this comes with the sql shell (a command line interface );
- open the sql shell
- run the command ```create database vet_clinic ``` which will create the vet_clinic database
- navigate to the database using  ```\c vet_clinic ```
- we can now create tables using  ``` create table table_name ```
- after creating the tables you can make all queries that yo may want 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Author <a name="author"></a>

👤 **Recillah Khamala**

- GitHub: [@Recillah-khamala](https://github.com/Recillah-Khamala)
- Twitter: [@recillahk](https://twitter.com/recillahk)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/recillah-khamala/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

> Describe 1 - 3 features you will add to the project.

- [Multiple tables ] **[include_other_tables]**
- [Relationship between tables ] **[build_relationships_between_tables]**
- [Relationship with multiple tables ] **[Build_group_relationships]**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Recillah-Khamala/Vet-Clinic-DB/issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

> Give credit to everyone who inspired your codebase.

I would like to thank microverse for including this in the carriculum.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>