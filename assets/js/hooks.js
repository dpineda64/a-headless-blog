const TabHook = {
  mounted() {
    const el = this.el;
    el.addEventListener('keydown', function(e) {
      if (e.keyCode === 9) {
        const start = this.selectionStart;
        const end = this.selectionEnd;
        const target = e.target;
        const value = target.value;

        target.value = value.substring(0, start) + '\t' + value.substring(end);
        this.selectionStart = this.selectionEnd = start + 1;
        e.preventDefault();
      }
    });
  },
};

export default {
  Tab: TabHook,
};
