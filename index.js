
exports.activate = function () {
  console.log('activated');
  atom.commands.add('atom-text-editor', {
    'wrap-in-tag:wrap': function () {
      wrap(atom.workspace.getActiveTextEditor());
    }
  });
}

function wrap (editor) {
  console.log('wrapping');
  if (!editor) return;
  var buffer = editor.getBuffer()
  ,   ranges = editor.getSelectedBufferRanges()
  ;
  // for each range:
  //  insert "<>" before and "</>" after
  //  position cursors inside those tags
  //  let user type at those positions
  //  the hard bit: when the user hits space, you only want to keep the cursors that are in
  //  the start tag
  ranges
    .forEach(function (range) {
      var start = range.start
      ,   end = range.end
      ;
      buffer.insert(start, "<>", { undo: true });
      buffer.insert(end, "</>", { undo: true });
      editor.addCursorAtBufferPosition([start.row, start.column - 1]);
      editor.addCursorAtBufferPosition([end.row, end.column + 2]);
    })
  ;
}
