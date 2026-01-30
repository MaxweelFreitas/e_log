import 'elog_renderable.dart';

/// Contrato base para componentes com ciclo de vida
///
/// Um componente:
/// - pode ser iniciado
/// - pode ser finalizado
/// - pode emitir renders ao longo do tempo
abstract class ELogComponent extends ELogRenderable {
  /// Inicia o componente
  ///
  /// Exemplo:
  /// - começa spinner
  /// - inicia timer
  /// - registra stream
  void start();

  /// Atualiza o estado interno
  ///
  /// Pode ser chamado várias vezes
  /// Ex: progresso, etapa atual, mensagem
  void update([dynamic payload]);

  /// Finaliza o componente
  ///
  /// Deve liberar recursos:
  /// - Timer
  /// - StreamSubscription
  /// - etc
  void stop();
}
