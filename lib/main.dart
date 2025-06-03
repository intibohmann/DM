import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Widgets',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Exemplo de Widgets',
                applicationVersion: '1.0.0',
                children: [
                  Text('Este é um exemplo de aplicativo Flutter com formulários.'),
                ],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Ir para o Cadastro de animais'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
            );
          },
        ),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  bool _aceitaTermos = false;
  String _genero = 'Masculino';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulároio de Cadastro de Animais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Informe o nome do animal'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value ?? '';
                },
              ),
              SizedBox(height: 16),
              Text('Selecione o gênero correspondente ao animal'),
              Row(
                children: [
                  Radio<String>(
                    value: 'Masculino',
                    groupValue: _genero,
                    onChanged: (value) {
                      setState(() {
                        _genero = value!;
                      });
                    },
                  ),
                  Text('Masculino'),
                  Radio<String>(
                    value: 'Feminino',
                    groupValue: _genero,
                    onChanged: (value) {
                      setState(() {
                        _genero = value!;
                      });
                    },
                  ),
                  Text('Feminino'),
                ],
              ),
              CheckboxListTile(
                title: Text('Aceito os termos'),
                value: _aceitaTermos,
                onChanged: (value) {
                  setState(() {
                    _aceitaTermos = value ?? false;
                  });
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  child: Text('Enviar'),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _aceitaTermos) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            nome: _nome,
                            genero: _genero,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String nome;
  final String genero;

  ResultScreen({required this.nome, required this.genero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome: $nome'),
            Text('Gênero: $genero'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
