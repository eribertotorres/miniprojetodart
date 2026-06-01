//TaskReport Dart: Simulador de Tratamento de Dados de Tarefas Mobile
//Mini-Projeto para o Curso de Dart / Flutter do Senai
//Primeira versão
//Branch-DEV
void main() {
  final listaConvertidaTarefa = dadosTarefas
      .map((item) => converterMapParaTarefa(item))
      .toList();

  for (var tarefa in listaConvertidaTarefa) {
    tarefa.exibirResumo();
  }

  print('\n'); // Imprime uma linha em branco, para separa o exibirResumo()

  //RF06
  for (var tarefa in listaConvertidaTarefa) {
    tarefa.exibirTarefasConvertidas();
  }

  final relatorio = RelatorioTarefas(listaConvertidaTarefa);

  relatorio.exibirTitulosPorStatus('concluida');
  relatorio.exibirTitulosPorStatus('em andamento');
  relatorio.exibirTitulosPorStatus('pendente');
  relatorio.exibirTitulosPorStatus('cancelada');
}

final List<Map<String, dynamic>> dadosTarefas = [
  {
    'id': 1,
    'titulo': 'Corrigir bug login',
    'responsavel': 'Ana',
    'status': 'concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 120,00',
    'horas': '2',
  },

  {
    'id': 2,
    'titulo': 'Criar tela de perfil',
    'responsavel': 'Bruno',
    'status': 'em andamento',
    'prioridade': 'media',
    'valor': 'R\$ 250,50',
    'horas': '5',
  },

  {
    'id': 3,
    'titulo': null,
    'responsavel': 'Carla',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 80,00',
    'horas': null,
  },

  {
    'id': 4,
    'titulo': 'Ajustar navegação',
    'responsavel': null,
    'status': 'concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 150,75',
    'horas': '3',
  },

  {
    'id': 5,
    'titulo': 'Revisar regras de negócio',
    'responsavel': 'Daniel',
    'status': 'cancelada',
    'prioridade': 'media',
    'valor': 'R\$ 0,00',
    'horas': '0',
  },

  {
    'id': 6,
    'titulo': 'Implementar validação de dados',
    'responsavel': 'Eduarda',
    'status': 'concluida',
    'prioridade': 'alta',
    'valor': 'R\$ 200,00',
    'horas': '4',
  },

  {
    'id': 7,
    'titulo': 'Organizar documentação',
    'responsavel': 'Felipe',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 90,00',
    'horas': '2',
  },
];

//RF01 - Transformar mapas em objetos
class ItemTrabalho {
  int id;
  String titulo;

  ItemTrabalho({required this.id, required this.titulo});
  void exibirResumo() {
    print('Item $id - $titulo');
  }
}

class Tarefa extends ItemTrabalho {
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  Tarefa({
    required int id,
    required String titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
  }) : super(id: id, titulo: titulo);

  @override //RF04
  void exibirResumo() {
    print('Tarefa $id - $titulo | Status: $status | Valor: R\$ $valor');
  }

  void exibirTarefasConvertidas() {
    print(
      'ID:  $id\n'
      'Titulo: $titulo\n'
      'Responsavel: $responsavel\n'
      'Status: $status\n'
      'Prioridade: $prioridade\n'
      'Valor: R\$ $valor\n'
      'Horas: $horas\n',
    );
  }
}

//RF02 - Tratar os campos nulos como solicitado
//RF03 - Ao usar o .trim() para tratar espaços extras
Tarefa converterMapParaTarefa(Map<String, dynamic> item) {
  return Tarefa(
    id: item['id'],
    titulo: (item['titulo'] ?? 'Sem titulo').toString().trim(),
    responsavel: (item['responsavel'] ?? 'Não informado').toString().trim(),
    status: (item['status'] ?? 'Sem status').toString().trim(),
    prioridade: (item['prioridade'] ?? 'Sem prioridade').toString().trim(),
    valor: converterValor(item['valor']),
    horas: converterHoras(item['horas']),
  );
}

//RF04 - Converter valores monetários para double
double converterValor(dynamic valor) {
  if (valor == null) {
    return 0.0;
  }

  String valorTexto = valor.toString();
  valorTexto = valorTexto.replaceAll('R\$', '');
  valorTexto = valorTexto.replaceAll(' ', '');
  valorTexto = valorTexto.replaceAll(',', '.');

  return double.tryParse(valorTexto) ?? 0.0;
}

//RF05 - Converter horas para número inteiro
int converterHoras(dynamic horas) {
  if (horas == null) {
    return 0;
  }

  return int.tryParse(horas.toString()) ?? 0;
}

//RF06 - Exibir todas as tarefas convertidas
class RelatorioTarefas {
  final List<Tarefa> _tarefas;

  RelatorioTarefas(List<Tarefa> tarefas) : _tarefas = tarefas;

  int get quantidadeTotal => _tarefas.length;

  //RF07
  void exibirTitulosPorStatus(String status) {
    print('\nTarefa $status');

    final tarefasFiltradas = _tarefas
        .where((tarefa) => tarefa.status == status)
        .toList();

    for (var tarefa in tarefasFiltradas) {
      print('- ${tarefa.titulo}');
    }
  }
}


// RF13 - Criar classe base e classe filha

//RF14 - aplicar encapsulamento

//RF15 - Gerar relatório final
//print(relatorio.final);