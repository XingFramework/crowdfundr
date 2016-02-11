import {ProjectState} from "../../src/app/projects/projectsStates.js";

describe("ProjectState", function() {
  var projectState,
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

    projectState = new ProjectState();
  });

  it("should resolve a project", function() {
    projectState.project(mockResources, mockStateParams);
    expect(mockResources.project).toHaveBeenCalledWith({id: '5'})
  });
});
