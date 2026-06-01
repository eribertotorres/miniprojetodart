//TaskReport Dart: Simulador de Tratamento de Dados de Tarefas Mobile
//Mini-Projeto para o Curso de Dart / Flutter do Senai
//Primeira versão
//Branch-DEV

void main();

final List<Map<String, dynamic>>dadosTarefas = [
  {
    'id':1,
    'titulo': 'Corrigir bug login',
    'responsavel': 'Ana',
    'status':'concluida',
    'prioridade':'alta',
    'valor': 'R\$ 120,00',
    'horas':'2',
    
  },

  {
    'id':2,
    'titulo': 'Criar tela de perfil',
    'responsavel': 'Bruno',
    'status':'em andamento',
    'prioridade':'media',
    'valor': 'R\$ 250,50',
    'horas':'5',

  },

  {
    'id':3,
    'titulo': 'null',
    'responsavel': 'Carla',
    'status':'pendente',
    'prioridade':'baixa',
    'valor': 'R\$ 80,00',
    'horas':null,
  },

{
    'id':4,
    'titulo': 'Ajustar navegação',
    'responsavel': null,
    'status':'concluida',
    'prioridade':'alta',
    'valor': 'R\$ 150,75',
    'horas':'3',
  },

  {
    'id':5,
    'titulo': 'Revisar regras de negócio',
    'responsavel': 'Daniel',
    'status':'cancelada',
    'prioridade':'media',
    'valor': 'R\$ 0,00',
    'horas':'0',
  },

  {
    'id':6,
    'titulo': 'Implementar validação de dados',
    'responsavel': 'Eduarda',
    'status':'concluida',
    'prioridade':'alta',
    'valor': 'R\$ 200,00',
    'horas':'4',
  },

  {
    'id':7,
    'titulo': 'Organizar documentação',
    'responsavel': 'Felipe',
    'status':'pendente',
    'prioridade':'baixa',
    'valor': 'R\$ 90,00',
    'horas':'2',
  },

];

//RF01 - Transformar mapas em objetos

class Tarefa {
  int id;
  String titulo;
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
  });

}

Tarefa converterMapParaTarefa(Map<String, dynamic> item) {
  return Tarefa(
    id:item['id'],
    titulo: item['titulo'] ?? 'Sem titulo',
    responsavel: item['responsavel'] ?? 'Não informado',
    status: item['status'] ?? 'Sem status',
    prioridade: item['prioridade'] ?? 'Sem prioridade',
    valor: converterValor(item['valor']),
    horas: converterHoras(item['horas']),
  );
}

//RF02 - Tratar campos nulos
/* 
Campo | Valor nulo deve virar
titulo "Sem Título"

Área destinada a tratamento de campos nulos

Switch ou if-else
*/

//RF03 - Remover espaços desnecessários

// usar trim()

/*
RF04 - Converter valor monetário para número
Exemplo de lógica esperada

double converterValor(dynamic valor){ 
if (valor == null) {
  return 0.0;
}
*/

  String valorTexto = valor.toString();
  valorTexto = valorTexto.replaceAll('R\$', '');
  valorTexto = valorTexto.replaceAll(' ', '');
  valorTexto = valorTexto.replaceAll(',', '.');

  return double.tryParse(valorTexto) ?? 0;

}

//RF05 - Converter horas para número inteiro

int converterHoras(dynamic horas) {
  if (horas == null) {
    return 0;    
  }

    return int.tryParse(horas.toString()) ?? 0; 

}

/*
RF06 - Exibir todas as tarefas convertidas

ID: 1
Titulo: Corrigir bug login
Responslavel: ana
Status: concluida
Prioridade: alta
Valor: R$ 120.00
Horas: 2

*/

// RF13 - Criar classe base e classe filha

class ItemTrabalho {
  int id;
  String titulo;

  ItemTRabalho({
    required this.id,
    requiered this.titulo,    
  });

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
    required this.valor.id
    required this.horas,
  }) : super (id: id, titulo: titulo);

  @override
  void exibirResumo() {
    print('Tarefa $id - $titulo | Status: $status | Valor: R$ $ valor');
  }
}

//RF14 - aplicar encapsulamento

class RelatorioTarefas {
  final List<tarefa> _tarefas;

  RelatorioTarefas(List<Tarefa> tarefas): _tarefas = tarefas;

  int get  quantidadeTotal => _tarefas.length;
}
