import { ProjectsEditCtrl } from "../../src/app/projects/projectsControllers.js";

describe('Projects Controllers', function() {

  var controller, mockProject;

  describe('ProjectsEditCtrl', function() {
    var mockPromise,
        mockProject;

    beforeEach(function() {
      mockPromise = function() {
        return Promise.resolve("");
      };
      mockProject = {
        update() { return mockPromise }
      };
      controller = new ProjectsEditCtrl(mockProject);
    });

    describe('save', function() {
      describe('on success', function() {
        beforeEach(function(done) {
          controller.save().then(() => {
            done();
          });
        });
      })
    });
  })
})
