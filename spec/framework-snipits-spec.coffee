FrameworkSnipits = require '../lib/framework-snipits'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "FrameworkSnipits", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('frameworkSnipits')

  describe "when the framework-snipits:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.framework-snipits')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'framework-snipits:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.framework-snipits')).toExist()
        atom.workspaceView.trigger 'framework-snipits:toggle'
        expect(atom.workspaceView.find('.framework-snipits')).not.toExist()
