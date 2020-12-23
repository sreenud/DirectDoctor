module.exports = {
  purge: [],
  theme: {
    extend: {
      colors: {
        'doctor-blue': '#191932',
        'doctor-yellow': '#e7ab00',
        'doctor-yellow-500': '#EEC44D',
        'hyperlink-blue': '#13347f',
        'doctor-gray-100': '#efeff1',
        'doctor-yellow-100': '#fdf7ea',
        'doctor-grayb-100': '#fbfbfb',
        'doctor-grayb-200': '#f5f5f5',
        'doctor-grayb-300': '#d9d9d9',
      },
      fontFamily: {
        hurmebold: ['HurmeBold'],
        glacial: ['Glacial'],
        glacialbold: ['GlacialBold'],
        glacialitalic: ['GlacialItalic'],
      },
      fontSize: {
        heading: '2.5rem',
        heading3: '1.75rem',
        heading5: '1.36rem',
        px18: '18px',
        px14: '14px',
        px20: '20px',
      },
      boxShadow: {
        'outline-yellow': '0 0 0 3px rgba(231, 171, 0, 1)',
      },
    },
  },
  variants: {
    extend: {
      // ...
      fill: ['hover', 'focus'],
      transitionDuration: ['hover', 'focus'],
    },
  },
  plugins: [],
};
