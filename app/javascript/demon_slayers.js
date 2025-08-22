document.addEventListener('turbo:load', function() {
  // Buscar el botón por su ID
  const exportButton = document.getElementById('btn-export-ds');

  // Verificar si el botón existe en la página actual
  if (exportButton) {

    // Obtener la URL base del atributo data-blank-url
    const baseUrl = exportButton.getAttribute('data-blank-url');

    // Encontrar todos los checkboxes con la clase 'choose-ds'
    const checkboxes = document.querySelectorAll('input.choose-ds');

    // Iterar sobre cada checkbox y añadir un listener
    checkboxes.forEach(function(checkbox) {
      checkbox.addEventListener('click', function(event) {
        // Encontrar todos los checkboxes seleccionados con la clase 'choose-ds'
        const selectedCheckboxes = document.querySelectorAll('input.choose-ds:checked');

        // Crear un arreglo con los valores de los checkboxes seleccionados
        const selectedValues = Array.from(selectedCheckboxes).map(checkbox => checkbox.value);

        // Crear la nueva URL con los ids seleccionados
        let newUrl = baseUrl;

        // Solo proceder si hay al menos un checkbox seleccionado
        if (selectedValues.length > 0) {
          // Crear una cadena de parámetros c[] para cada valor
          const paramString = selectedValues.map(value => 'c[]=' + value).join('&');
          
          // Agregar los parámetros a la URL base
          if (newUrl.includes('?')) {
            newUrl += '&' + paramString;
          } else {
            newUrl += '?' + paramString;
          }
        }

        // Establecer el nuevo href
        exportButton.setAttribute('href', newUrl);
        console.log("nueva URL: " + newUrl);
      });
    });

  }
});