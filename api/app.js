const express = require("express");
var { graphqlHTTP } = require("express-graphql");

const schema = require("./schema/schema");
const testSchema = require("./schema/types_schema");
const mongoose = require("mongoose");

const {config} = require("./config");

const app = express();
const port = process.env.PORT || 4000;
const cors = require("cors");

app.use(cors());
app.use(
  "/graphql",
  graphqlHTTP({
    graphiql: true,
    schema,
  })
);

mongoose
  .connect(
    // mongodb+srv://messi:<password>@graphqlcluster.afjkr.mongodb.net/myFirstDatabase?retryWrites=true&w=majority
    `mongodb+srv://${config.mongo.user}:${config.mongo.password}@${config.mongo.host}/${config.mongo.dbName}?retryWrites=true&w=majority
`,
    { useNewUrlParser: true, useUnifiedTopology: true }
  )
  .then(() => {
    app.listen({ port: port }, () => {
      console.log("Listening for requests on my awesome port " + port);
    });
  })
  .catch((e) => {
    return console.log("Error:::" + e);
  });
