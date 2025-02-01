# How to Install

To get started, you need to have **nvm** (Node Version Manager) installed, version 1.2.2 (or the latest version available).

1. Install the latest LTS version of Node.js:

   ```bash
   nvm install --lts
2. Navigate to the Dashboard/admin directory:
    ```bash
    cd Dashboard/admin
3. Then, install the project dependencies:
    ```bash
    npm -i .
4. install the sql database
    ```bash
    then you can take the file web.sql and make a new database and copy the content inside after you need to change connectionString to yours correspond db inside web.config.
# what is the project about 
    the project is about stock management with graph detail about Orders . in this project i used webforms to add edit delete update product using inline editing .
for the dashboard of the admin i used angular latest version and .Net api to send data to the frontend 