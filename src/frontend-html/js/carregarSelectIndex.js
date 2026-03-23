fetch('http://localhost:8080/index')
.then(response => response.json())
.then(data => {
     console.log(data)
    const selectTipo = document.getElementById("tipoAtividade");
    const selectAtividade = document.getElementById("atividade");

    data.tipoAtividade.forEach(item => {    

        let option = document.createElement("option");
        option.value = item.id;
        option.text = item.descricao;

        selectTipo.appendChild(option);

    });

  //  selectTipo.selectedIndex = 0;

    data.atividade.forEach(item => {

        let option = document.createElement("option");
        option.value = item.id;
        option.text = item.descricao;

        selectAtividade.appendChild(option);

    });

    carregarAtividades();

    function carregarAtividades() {

    const selectTipo = document.getElementById("tipoAtividade");
    const selectAtividade = document.getElementById("atividade");

    const tipoSelecionado = Number(selectTipo.value);

    selectAtividade.innerHTML = "";

    data.atividade
        .filter(a => a.id_tipoatividade == tipoSelecionado)
        .forEach(item => {

            let option = document.createElement("option");
            option.value = item.id;
            option.text = item.descricao;

            selectAtividade.appendChild(option);

        });
    }

    document.getElementById("tipoAtividade").addEventListener("change", carregarAtividades);

});