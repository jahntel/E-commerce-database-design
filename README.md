# E-commerce Database Design

## 🎯 Objective

This project is a peer group assignment focused on designing and implementing an e-commerce database from scratch. The objective is to master database design principles by creating an Entity-Relationship Diagram (ERD) and the corresponding SQL code to build the database structure.

## 🛠️ Instructions

The project involved the following steps:

1. **ERD Creation:** Designing the database structure, defining entities (tables), attributes, relationships, primary keys, foreign keys, and constraints. This was visualized using an ERD tool (or Mermaid code).

2. **Data Flow Planning:** Mapping out how data flows between entities and planning the database structure and implementation collaboratively.

3. **Group Collaboration:** Working together on all phases of the project, ensuring shared understanding and effective teamwork.

4. **Database Implementation:** Writing the SQL code to create the database and all specified tables.

5. **Testing:** Creating and running SQL scripts to test the database structure and data insertion.

## 🗃️ Database Structure

The database is named `ecomercedb` and includes the following tables:

* `brand`

* `product_category`

* `product`

* `product_image`

* `product_item`

* `color`

* `size_category`

* `size_option`

* `product_variation`

* `attribute_type`

* `attribute_category`

* `product_attribute`

## 📊 Entity-Relationship Diagram (ERD)

The database structure is visualized in the Entity-Relationship Diagram. The ERD shows the entities, their attributes, and the relationships between them.

*(You can either include an image of your ERD here or include the Mermaid code directly if your platform supports rendering it.)*

```mermaid
erDiagram
    brand {
        INT brand_id PK
        VARCHAR brand_name
    }

    product_category {
        INT category_id PK
        VARCHAR category_name
        INT parent_category_id FK "Optional self-referencing for subcategories"
    }

    product {
        INT product_id PK
        VARCHAR product_name
        DECIMAL base_price
        INT brand_id FK
        INT category_id FK
        TEXT description
    }

    product_image {
        INT image_id PK
        INT product_id FK
        VARCHAR image_url
        BOOLEAN is_main_image
    }

    product_item {
        INT product_item_id PK
        INT product_id FK
        DECIMAL price
        INT quantity_in_stock
        VARCHAR sku
    }

    color {
        INT color_id PK
        VARCHAR color_name
        VARCHAR hex_code
    }

    size_category {
        INT size_category_id PK
        VARCHAR category_name "e.g., Clothing, Shoe"
    }

    size_option {
        INT size_option_id PK
        INT size_category_id FK
        VARCHAR size_value "e.g., S, M, L, 42"
    }

    product_variation {
        INT product_variation_id PK
        INT product_item_id FK
        INT color_id FK "Optional, if color is a variation"
        INT size_option_id FK "Optional, if size is a variation"
    }

    attribute_type {
        INT attribute_type_id PK
        VARCHAR type_name "e.g., text, number, boolean"
    }

    attribute_category {
        INT attribute_category_id PK
        VARCHAR category_name "e.g., Physical, Technical"
    }

    product_attribute {
        INT product_attribute_id PK
        INT product_id FK
        INT attribute_category_id FK
        INT attribute_type_id FK
        VARCHAR attribute_name
        VARCHAR attribute_value "Stores the value based on type"
    }

    brand ||--|{ product : "has"
    product_category ||--|{ product : "categorizes"
    product ||--|{ product_image : "has"
    product ||--|{ product_item : "has"
    product_item ||--|{ product_variation : "can have"

    product_category ||--o{ product_category : "can have parent"

    color ||--o{ product_variation : "is variation of"
    size_option ||--o{ product_variation : "is variation of"
    size_category ||--|{ size_option : "groups"

    attribute_type ||--|{ product_attribute : "defines type of"
    attribute_category ||--|{ product_attribute : "categorizes"
    product ||--|{ product_attribute : "has"

```
*(Replace the above Mermaid code block with an image reference if you prefer)*

## 🚀 Setup and Usage

1. **Clone the repository:**

   ```bash
   git clone <repository_url>

   ```

2. **Navigate to the repository directory:**

   ```bash
   cd <repository_name>

   ```

3. **Create the database:** Use a SQL client (like MySQL Workbench, pgAdmin, or the command line) to execute the `ecommerce.sql` file. This script will create the `ecomercedb` database and all necessary tables.

   ```bash
   mysql -u your_username -p < ecommerce.sql
   # Or for PostgreSQL:
   # psql -U your_username -d your_database -f ecommerce.sql

   ```

   *(Adjust the command based on your specific database system)*

4. **Run the test script:** Execute the `ecommerce_sql_test.sql` script to insert sample data and run test queries.

   ```bash
   mysql -u your_username -p ecomercedb < ecommerce_sql_test.sql
   # Or for PostgreSQL:
   # psql -U your_username -d ecomercedb -f ecommerce_sql_test.sql

   ```

## 🧪 Testing

The `ecommerce_sql_test.sql` file contains SQL commands to:

* Insert sample data into all tables.

* Execute various `SELECT` queries to verify data integrity and relationships between tables.

Running this script will help confirm that the database structure is correctly implemented and can store and retrieve data as expected.

## 🧑‍🤝‍🧑 Group Collaboration

This project was developed collaboratively using GitHub for version control. Key aspects of our collaboration included:

* Regular meetings to discuss design decisions and progress.

* Using GitHub for code sharing, version tracking, and issue management.

* Mutual review and understanding of all parts of the project.

## 📂 Submission

The final ERD and the `ecommerce.sql` file are available in this public GitHub repository, ensuring accessibility for review.
