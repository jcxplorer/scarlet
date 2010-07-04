(function($) {
  jQuery.easing.def = "easeOutQuart"; // For tweening

  var allSlides = function() {
    return $('#slides #track > div');
  }
  
  var slideDimensions = function() {
    return {
      width: $(window).width(),
      height: $(window).height()
    }
  }
  
  var getIndex = function() {
    var index = document.location.hash.split('#')[1];
    return Number(index);
  }
  
  var setIndex = function(idx) {
    var newSlide = '#slide-' + idx;
    if ($(newSlide).size() < 1) { return false; }
    document.location.hash = '#' + idx;
  }

  var setTitle = function(idx) {
    var newSlide = '#slide-' + idx;
    var value = $(newSlide).attr("title");
    if (value == "") { $('title').html("Slides"); }
    else { $('title').html(value); }
  }
  
  var setSlideDimensions = function() {
    var dimensions = slideDimensions();
    
    $('#slides').height(dimensions.height);
    $('#slides').width(dimensions.width);
    
    allSlides().height(dimensions.height);
    allSlides().width(dimensions.width);
  }
  
  var showCurrentSlide = function() {
    var dimensions = slideDimensions();
    var index = getIndex();
    var offset = (index || 0) * dimensions.width;
    
    $('#track').animate({ marginLeft: '-' + offset + 'px' }, 200);
  }
  
  var verticalAlign = function() {
    var dimensions = slideDimensions();
    var margin = (dimensions.height - $(this).height()) / 2;
    $(this).css({ paddingTop: margin + 'px' });
  }

  var formatGist = function() {
    $('.gist-meta').css({ fontSize: '12px' });
    $('.gist .gist-file .gist-data pre').css({
      padding: '0.4em',
      overflow: 'hidden',
      fontSize: '26px'
    });
    
    allSlides().find('.content').each(verticalAlign);
  }
  
  var adjustSlides = function() {
    var dimensions = slideDimensions();
    
    setSlideDimensions();
    showCurrentSlide();

    formatGist();
  }

  var isNumber = function(key) {
    return key >= 48 && key <= 57;
  }

  var numberBuffer = new String();

  var addToNumberBuffer = function(num) {
    numberBuffer = numberBuffer + (num - 48);
  }

  var jumpToSlide = function(event) {
    if (numberBuffer.length > 0) {
      event.preventDefault();
      event.stopPropagation();
      setIndex(numberBuffer);
    }
    numberBuffer = new String();
  }

  var move = function(event) {
    var DIRECTIONS = {
      37: -1,     // ARROW LEFT
      39: 1,      // ARROW RIGHT
      32: 1,      // SPACE BAR
      13: 1,      // RETURN
      27: 'home', // ESCAPE
      71: 'jump', // g
      left: -1,
      right: 1
    }
    
    if (isNumber(event.which)) {
      addToNumberBuffer(event.which);
    }

    else if (dir = DIRECTIONS[event.which || event]) {
      if (dir == 'jump') {
        jumpToSlide(event);
      }
      else if (dir == 'home') {
        event.preventDefault();
        event.stopPropagation();
        location.href = '#0';
      } else {
        setIndex(getIndex() + dir);
      }
      setTitle(getIndex());
    }
  }
  
  function clickMove(e) {
    if (e.pageX < ($(window).width() / 2)) {
      move('left');
    } else {
      move('right');
    }
  }
  
  $(window).bind('resize', function() { adjustSlides(); });
  $(document).bind('keydown', move);
  $(document).bind('hash.changed', adjustSlides);
  $(document).bind('click', clickMove);
  $(document).ready(function() {
    setIndex(getIndex() || 0);
    setTitle(getIndex() || 0);
    $(this).trigger('hash.changed');
    if (document.location.search.indexOf('notes') == 1) {
      $('.notes').show();
    }
  });
})(jQuery);
