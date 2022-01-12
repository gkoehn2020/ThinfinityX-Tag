var jsro = null;

xtag.register('x-simple-ponent', {
  content: `<div>
    My Custom Text from X-Tag...
            </div>`,
  lifecycle: {
    created  : function(){ 
      /* Called when the custom element is created */

      virtualUI.onReceiveMessage = function (message) {
        if (message) {
          message = JSON.parse(message);
          switch (message.Action) {
            case 'orion-working-start':
              document.getElementById("splash").style.display = "block";
              document.getElementById("splashgif").style.display = "inline";
              document.getElementById("splashTitle").innerHTML = message.Title;
              document.getElementById("splashMessage").innerHTML = message.Msg;
              break;
            case 'orion-working-stop':
              document.getElementById("splash").style.display = "none";
              document.getElementById("splashgif").style.display = "none";
              document.getElementById("splashTitle").innerHTML = "";
              document.getElementById("splashMessage").innerHTML = "";
              break;
            case 'orion-working-msg':
              document.getElementById("splashTitle").innerHTML = message.Title;
              document.getElementById("splashMessage").innerHTML = message.Msg;
              break;
          }
        }
      };

    },
    inserted : function(){ 
      /* Called when the custom element is inserted into the DOM */ 
      startJsRO(this.id);
    },
    removed  : function(){ 
      /* Called when the custom element is removed from the DOM */ 
    },
    attributeChanged: function(attrName, oldValue, newValue){
      /* Called when the attribute of the custom element is changed */
    }
  },
  accessors : {},
  methods   : {},
  events    : {}
});

function startJsRO(controlId) {
  var jsro = new Thinfinity.JsRO();
  var ro = null;

  jsro.on('model:ro', 'created', function () {
    ro = jsro.model.ro;
  });

  jsro.on('ro', 'dohtml2canvasop', function () {
    html2canvas(document.body,{background: '#fff'}).then(function(canvas) {
      var base64URL = canvas.toDataURL('image/png');
      ro.data = base64URL;
    });
  });
};
