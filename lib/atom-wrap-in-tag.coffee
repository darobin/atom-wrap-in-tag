AtomWrapInTagView = require './atom-wrap-in-tag-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomWrapInTag =
  atomWrapInTagView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomWrapInTagView = new AtomWrapInTagView(state.atomWrapInTagViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomWrapInTagView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-wrap-in-tag:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomWrapInTagView.destroy()

  serialize: ->
    atomWrapInTagViewState: @atomWrapInTagView.serialize()

  toggle: ->
    console.log 'AtomWrapInTag was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
