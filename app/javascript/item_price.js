window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");

  if (priceInput !== null) { 
    priceInput.addEventListener("input", () => {
      const addTaxDom = document.getElementById("add-tax-price");
      const addPofitDom = document.getElementById("profit");

      if (addTaxDom !== null && addPofitDom !== null) { 
        addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1);
        addPofitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1));
      } else {
        console.error("Element not found: add-tax-price or profit");
      }
    });
  } else {
    console.error("Element not found: item-price");
  }
});