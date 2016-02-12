import { ProjectEditController, ProjectNewController } from "../../src/app/projects/projectsControllers.js";

describe('Projects Controllers', function() {

  describe('ProjectEditController', function() {
    var controller,
        mockProject,
        mockState;

    describe('save', function() {
      describe('on success', function() {

        beforeEach(function(done) {
          mockProject = { update() { return Promise.resolve(this) },
                          shortLink: '1' };
          mockState = jasmine.createSpyObj("mockState", ["go"]);
          controller = new ProjectEditController(mockProject, mockState);
          controller.save().then(() => done());
        });

        it ("calls go with the correct arguments", function() {
          expect(mockState.go).toHaveBeenCalledWith("root.inner.project", {id: "1"});
        })
      })
    })
  })

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
