import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/bloc/configuracion/configuracion_bloc.dart';
import 'package:turismo_app/providers/providers.dart';
import 'package:turismo_app/repositories/repository.dart';

import 'package:path_provider/path_provider.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:turismo_app/theme/style.dart';
import 'package:turismo_app/screens/screens.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
        ..maxConnectionsPerHost = 50;
  }
}

/* class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
} */

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  // Soluciona error de carga de NetworkImages
  // limitando las peticiones simultáneas
  HttpOverrides.global = MyHttpOverrides();

  BlocSupervisor.delegate = await HydratedBlocDelegate.build(
    storageDirectory: await getApplicationDocumentsDirectory()
  );

  final EstablecimientosRepository repository = EstablecimientosRepository(
    alojamientoProvider: AlojamientoProvider(
      httpClient: 
        http.Client(),
    ),
    gastronomicoProvider: GastronomicoProvider.create()
  );

  runApp(App(
    repository: repository,
  ));
}

class App extends StatelessWidget {
  final EstablecimientosRepository repository;

  App({
    Key key, 
    @required this.repository,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EstablecimientosBloc(repository: repository),
        ),
        BlocProvider(
          create: (context) => FavoritosBloc(),
        ),
        BlocProvider(
          create: (context) => ConfiguracionBloc(),
        )
      ],
      child: BlocBuilder<ConfiguracionBloc, ConfiguracionState>(
        builder: (context, state) {
          if (state is ConfiguracionInitial) {
            BlocProvider.of<ConfiguracionBloc>(context).add(FetchConfiguracion());
          }

          if (state is ConfiguracionSuccess)
            return MaterialApp(
              title: 'Turismo App',
              debugShowCheckedModeBanner: false,
              themeMode: state.config['dark-mode'] ? ThemeMode.dark : ThemeMode.light,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              initialRoute: '/',
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) => RootScreen(),
                '/filtros': (BuildContext context) => FiltrosScreen()
              },
            );
        }
      )
    );
  }
}
