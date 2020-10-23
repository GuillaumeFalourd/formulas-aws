const run = require("./formula/formula");

run(process.env.PROVIDER, process.env.CIRCLECI_TOKEN, process.env.USER, process.env.PROJECT);
