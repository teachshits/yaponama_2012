$(function(){
  $(document).bind('drop', function (e) {
      var url = $(e.originalEvent.dataTransfer.getData('text/html')).filter('img').attr('src');
      if (url) {
          $.getImageData({
              server: "http://192.168.2.7:8800/",
              url: url,
              success: function (img) {
                  var canvas = document.createElement('canvas');
                  canvas.width = img.width;
                  canvas.height = img.height;
                  if (canvas.getContext && canvas.toBlob) {
                      canvas.getContext('2d').drawImage(img, 0, 0, img.width, img.height);
                      canvas.toBlob(function (blob) {
                          $('#fileupload').fileupload('add', {files: [blob]});
                      }, "image/jpeg");
                  }
              }
          });
      }
  });
})
