import Glide from '@glidejs/glide';

const carousels = document.querySelectorAll('.glide');
Object.values(carousels).map((carousel) => {
  console.log(carousel);
  const slider = new Glide(carousel, {
    type: 'carousel',
    focusAt: 1,
    startAt: 1,
    perView: 3,
    slidesToScroll: 1,
    keyboard: true,
    gap: 20,
    loop: true,
    dragThreshold: false,
    rewind: true,
    peek: {
      before: 0,
      after: 0,
    },
    breakpoints: {
      1024: {
        perView: 2,
      },
      600: {
        perView: 1,
      },
    },
  });
  slider.mount();
  return false;
});
