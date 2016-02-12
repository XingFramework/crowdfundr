import { ProjectController, ProjectEditController, ProjectNewController }
  from "../../src/app/projects/projectsControllers.js";

describe('Projects Controllers', function() {
    var controller

  describe("ProjectController", function(){
    var mockProject, mockState, mockCurrentUser;

    beforeEach(function() {
      mockProject = {};
      mockState = jasmine.createSpyObj("mockState", ["go"]);
      mockCurrentUser = {}

      controller = new ProjectController(mockProject, mockState, mockCurrentUser)
    });

    describe("edit()", function() {
      it("calls go with the correct arguments", function() {
        controller.project = {shortLink: "777"}

        controller.edit();

        expect(mockState.go).
          toHaveBeenCalledWith("root.inner.projectEdit", {id: "777"});
      });
    });

    describe("currentUserCanEdit(),", function() {
      describe("when current user is falsy,", function() {
        beforeEach(function() {
          controller.currentUser = { user: null };
          controller.project = { userId: 23 }
        });

        it ("returns falsy", function() {
          expect(controller.currentUserCanEdit()).toBeFalsy();
        });
      });

      describe("when current user is present", function() {
        beforeEach(function() {
          controller.currentUser = {
            user: { id: 23 }
          };
        });

        describe("and matches the project's user,", function() {
          beforeEach(function() {
            controller.project = { userId: 23 };
          });

          it("returns true", function() {
            expect(controller.currentUserCanEdit()).toEqual(true);
          });
        });

        describe("and doesn't match the project's user,", function() {
          beforeEach(function() {
            controller.project = { userId: 42 };
          });

          it("returns false", function() {
            expect(controller.currentUserCanEdit()).toEqual(false);
          });
        });
      });
    });
  });

  describe('ProjectEditController', function() {
    var mockProject,
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
        });
      });
    });
  });

  describe("ProjectNewController", function() {
    var mockRelayer, mockResources, mockState, mockCurrentUser;

    beforeEach(function() {
      mockRelayer = jasmine.createSpyObj("mockRelayer", ["new", "create"]);

      mockResources = {
        projects: function() {return mockRelayer},
      };

      mockState = jasmine.createSpyObj("mockState", ["go"]);

      mockCurrentUser = {
        user: {
          id: 1
        }
      };

      controller = new ProjectNewController(mockResources, mockState,
                                            mockCurrentUser);
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
          controller.project = {};
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
