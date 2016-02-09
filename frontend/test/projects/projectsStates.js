import {ProjectsState} from "../../src/app/projects/projectsStates.js";

describe("ProjectsState", function() {
  var projectsState,
    mockResources,
    mockProjectResource,
    mockStateParams;

  beforeEach(function() {
    mockStateParams = {
      id: '5'
    }

    mockProjectResource = jasmine.createSpyObj('project resource', ['load']);

    mockResources = {
      project: jasmine.createSpy('project').and.returnValue(mockProjectResource)
    }

    projectsState = new ProjectsState();
  });

  it("should resolve a project", function() {
    projectsState.project(mockResources, mockStateParams);
    expect(mockResources.project).toHaveBeenCalledWith({id: '5'})
  });
});
