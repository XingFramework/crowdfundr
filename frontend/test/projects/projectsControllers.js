import { ProjectsEditCtrl, ProjectNewController } from "../../src/app/projects/projectsControllers.js";

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

describe("Projects Controllers", function() {

  describe("ProjectNewController", function() {
    var controller
    var mockRelayer, mockResources, mockState;

    beforeEach(function() {
      mockRelayer = jasmine.createSpyObj("mockRelayer", ["new", "create"]);

      mockResources = {
        projects: function() {return mockRelayer},
      };

      mockState = jasmine.createSpyObj("mockState", ["go"]);

      controller = new ProjectNewController(mockResources, mockState);
    });

    describe("on initialization", function() {
      it("creates a new project", function() {
        expect(mockRelayer.new).toHaveBeenCalled();
      });
    });

    describe(".save()", function() {
      describe("when successful", function() {
        var mockPromise, mockProject;

        beforeEach(function() {
          mockProject = {shortLink: "3"};
          mockPromise = Promise.resolve(mockProject);
          mockRelayer.create.and.returnValue(mockPromise);
        });

        it("calls go with the correct arguments", function(done) {
          controller.save();

          mockPromise.then((mock) => {
            expect(mockState.go).
              toHaveBeenCalledWith("root.inner.project", {id: "3"});
            done();
          }, (error) => {
            expect(error).toEqual(NaN)
          });
        });
      });
    });
  });
});
