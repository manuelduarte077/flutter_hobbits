exports.config = {
    mongo: {
        dbName: process.env.MONGO_DATABASE,
        host: process.env.MONGO_HOST,
        port: process.env.MONGO_PORT,
        user: process.env.MONGO_USER_NAME,
        password: process.env.MONGO_USER_PASSWORD,
    }
}