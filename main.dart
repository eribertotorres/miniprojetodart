//TaskReport Dart: Simulador de Tratamento de Dados de Tarefas Mobile
//Mini-Projeto para o Curso de Dart / Flutter do Senai
//Primeira versão
//Branch-feat/relatorio-tarefas
void main() {
  try {
    final listaConvertidaTarefa = dadosTarefas
        .map((item) => converterMapParaTarefa(item))
        .toList();

    final relatorio = RelatorioTarefas(listaConvertidaTarefa);

    relatorio.gerarRelatorioFinal();
  } catch (e) {
    print('Erro ao executar o relatório: $e');
  }
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

  bool tituloEraNulo;
  bool responsavelEraNulo;
  bool horasEraNula;

  Tarefa({
    required int id,
    required String titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
    required this.tituloEraNulo,
    required this.responsavelEraNulo,
    required this.horasEraNula,
  }) : super(id: id, titulo: titulo);

  @override
  void exibirResumo() {
    print('Tarefa $id - $titulo | Status: $status | Valor: R\$ $valor');
  }

  void exibirTarefasConvertidas() {
    print(
      'ID: $id\n'
      'Titulo: $titulo\n'
      'Responsavel: $responsavel\n'
      'Status: $status\n'
      'Prioridade: $prioridade\n'
      'Valor: R\$ $valor\n'
      'Horas: $horas\n',
    );
  }
}

Tarefa converterMapParaTarefa(Map<String, dynamic> item) {
  return Tarefa(
    id: item['id'],
    titulo: (item['titulo'] ?? 'Sem titulo').toString().trim(),
    responsavel: (item['responsavel'] ?? 'Não informado').toString().trim(),
    status: (item['status'] ?? 'Sem status').toString().trim(),
    prioridade: (item['prioridade'] ?? 'Sem prioridade').toString().trim(),
    valor: converterValor(item['valor']),
    horas: converterHoras(item['horas']),
    tituloEraNulo: item['titulo'] == null,
    responsavelEraNulo: item['responsavel'] == null,
    horasEraNula: item['horas'] == null,
  );
}

double converterValor(dynamic valor) {
  try {
    if (valor == null) {
      return 0.0;
    }

    String valorTexto = valor.toString();
    valorTexto = valorTexto.replaceAll('R\$', '');
    valorTexto = valorTexto.replaceAll(' ', '');
    valorTexto = valorTexto.replaceAll(',', '.');

    return double.tryParse(valorTexto) ?? 0.0;
  } catch (e) {
    print('Erro ao converter valor: $valor');
    return 0.0;
  }
}

int converterHoras(dynamic horas) {
  try {
    if (horas == null) {
      return 0;
    }

    return int.tryParse(horas.toString()) ?? 0;
  } catch (e) {
    print('Erro ao converter horas: $horas');
    return 0;
  }
}

class RelatorioTarefas {
  final List<Tarefa> _tarefas;

  RelatorioTarefas(List<Tarefa> tarefas) : _tarefas = tarefas;

  int get quantidadeTotal => _tarefas.length;

  List<Tarefa> filtrarPorStatus(String status) {
    return _tarefas.where((tarefa) => tarefa.status == status).toList();
  }

  double somarValoresTarefasConcluidas() {
    final tarefasConcluidas = filtrarPorStatus('concluida');

    if (tarefasConcluidas.isEmpty) {
      return 0.0;
    }

    final valores = tarefasConcluidas.map((tarefa) => tarefa.valor).toList();

    return valores.reduce((total, valor) => total + valor);
  }

  double mediaValoresTarefasPendentes() {
    final tarefasPendentes = filtrarPorStatus('pendente');

    if (tarefasPendentes.isEmpty) {
      return 0.0;
    }

    final valores = tarefasPendentes.map((tarefa) => tarefa.valor).toList();

    final soma = valores.reduce((total, valor) => total + valor);

    return soma / tarefasPendentes.length;
  }

  int calcularHorasPorStatus(String status) {
    final tarefasFiltradas = filtrarPorStatus(status);

    if (tarefasFiltradas.isEmpty) {
      return 0;
    }

    final horas = tarefasFiltradas.map((tarefa) => tarefa.horas).toList();

    return horas.reduce((total, hora) => total + hora);
  }

  Set<String> obterStatusUnicos() {
    return _tarefas.map((tarefa) => tarefa.status).toSet();
  }

  void identificarDadosIncompletos() {
    print('\nTarefas com dados incompletos:');

    for (var tarefa in _tarefas) {
      if (tarefa.tituloEraNulo) {
        print('ID ${tarefa.id} - Título ausente');
      }

      if (tarefa.responsavelEraNulo) {
        print('ID ${tarefa.id} - Responsável ausente');
      }

      if (tarefa.horasEraNula) {
        print('ID ${tarefa.id} - Horas ausentes');
      }
    }
  }

  void gerarRelatorioFinal() {
    print('RELATÓRIO FINAL DE TAREFAS\n');

    print('Total de tarefas analisadas: $quantidadeTotal');
    print('Tarefas concluídas: ${filtrarPorStatus('concluida').length}');
    print('Tarefas pendentes: ${filtrarPorStatus('pendente').length}');
    print('Tarefas em andamento: ${filtrarPorStatus('em andamento').length}');
    print('Tarefas canceladas: ${filtrarPorStatus('cancelada').length}');

    print(
      '\nValor total das concluídas: R\$ ${somarValoresTarefasConcluidas()}',
    );

    final mediaPendentes = mediaValoresTarefasPendentes();

    if (mediaPendentes == 0.0) {
      print(
        'Média de valor das pendentes: Não existem tarefas pendentes sem média.',
      );
    } else {
      print('Média de valor das pendentes: R\$ $mediaPendentes');
    }

    print(
      'Total de horas concluídas: ${calcularHorasPorStatus('concluida')} horas',
    );

    print('\nStatus encontrados:');
    for (var status in obterStatusUnicos()) {
      print('- $status');
    }

    identificarDadosIncompletos();
  }
}
