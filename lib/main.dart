import 'package:flutter/material.dart';
import 'package:code_challenger/componentes/form.dart';
import 'package:code_challenger/controller/verifica_medidas.dart';
import 'package:code_challenger/controller/calcula_pintura.dart';

void main() {
  runApp(MyApp());
}

const _rotuloAlturaParede = 'Altura da parede:';
const _rotuloLarguraParede = 'Largura da parede:';
const _rotuloQuantPortas = 'Quantidade de portas:';
const _rotuloQuantJanelas = 'Quantidade de janelas:';
const _dicaMedida = '5.8';
String resultadoFinal = "Entre c/ nums inteiros (3) ou decimais (3.0)";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Rep',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MyHomePage(title: 'Code Challenger'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double dimensao;
  String dimensaoItens;
  var _controllerAlturaParede = TextEditingController();
  var _controllerLarguraParede = TextEditingController();
  var _controllerPortas = TextEditingController();
  var _controllerJanelas = TextEditingController();

  int _numWall = 1;
  double metragemDaSala = 0;

  void _varreCampos() {
    setState(() {
      dimensao = validarDimensao(
          _controllerLarguraParede.text, _controllerAlturaParede.text);

      debugPrint('retorno da $dimensao');

      if (dimensao == erroDadoInvalido() || dimensao == null) {
        resultadoFinal = 'Valor(es) inválido(s).';
      }
      if (dimensao == erroLargura()) {
        resultadoFinal =
            "Área total d parede $_numWall deve ter entre 1m² e máximo 15m²";
        debugPrint('$erroAreaParede()');
      }
      if (dimensao == erroAltura()) {
        resultadoFinal =
            "Área total d parede $_numWall deve ter entre 1m² e máximo 15m²";
        debugPrint('$erroAreaParede()');
      } else {
        dimensaoItens = quantItensParede(
            dimensao,
            double.tryParse(_controllerPortas.text),
            double.tryParse(_controllerJanelas.text),
            double.tryParse(_controllerAlturaParede.text),
            _numWall);

        switch (dimensaoItens) {
          case "Limite ultrapassado":
            resultadoFinal = "Altura errada ou portas e janelas > 50%";
            _numWall += 0;
            break;

          case "Altura inferior":
            resultadoFinal = "Altura errada ou portas e janelas > 50%";
            _numWall += 0;
            break;

          case "Valores estao dentro dos limites":
            metragemDaSala += dimensao;
            _controllerAlturaParede.text = "";
            _controllerLarguraParede.text = "";
            _controllerPortas.text = "";
            _controllerJanelas.text = "";

            debugPrint('Area total da sala m² $metragemDaSala');

            if (_numWall == 4) {
              resultadoFinal = calculaQuantLatas(metragemDaSala);
              _numWall = 0;
            }

            _numWall++;
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Digite as medidas da parede e quantidade de portas e janelas:',
              style: TextStyle(fontSize: 24.0),
            ),
            FormDados(
                controlador: _controllerAlturaParede,
                dica: _dicaMedida,
                rotulo: _rotuloAlturaParede,
                icone: Icons.square_foot),
            FormDados(
                controlador: _controllerLarguraParede,
                dica: _dicaMedida,
                rotulo: _rotuloLarguraParede,
                icone: Icons.square_foot),
            FormDados(
                controlador: _controllerPortas,
                dica: _dicaMedida,
                rotulo: _rotuloQuantPortas,
                icone: Icons.square_foot),
            FormDados(
                controlador: _controllerJanelas,
                dica: _dicaMedida,
                rotulo: _rotuloQuantJanelas,
                icone: Icons.square_foot),
            Text(
              'Parede Nº $_numWall',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '',
            ),
            Text(
              '$resultadoFinal',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _varreCampos,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        //apagarCampos();
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
