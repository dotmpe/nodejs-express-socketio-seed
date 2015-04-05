local_dev_paths = {
  app: './project',
  jquery: '/components/jquery/dist/jquery',
  underscore: "/components/underscore/underscore",
};
requirejs.config({
  baseUrl: '/script/',
  paths: local_dev_paths,
});
require(["app/document"]);
