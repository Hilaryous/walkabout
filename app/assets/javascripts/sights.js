var do_on_load = function() {
  $('#s3_uploader').S3Uploader(
    {
      remove_completed_progress_bar: false,
      progress_bar_target: $('#uploads_container'),
      allow_multiple_files: false
    }
  );
  $('#s3_uploader').bind('s3_upload_failed', function(e, content) {
    return alert(content.filename + ' failed to upload due to a timeout.');
  });

  $('#s3_uploader').bind('s3_upload_complete', function(e, content) {
    return alert(content.filename + ' has been uploaded');
});

};




$(document).ready(do_on_load);
$(window).bind('page:change', do_on_load);
