class PhishingDetector {
  static final List<String> phishingKeywords = [
    "clique aqui",
    "verificar sua conta",
    "urgente",
    "suspensão da conta",
    "confirme seu cadastro",
    "valide sua conta"
  ];

  static String classifyEmail(String titulo, String descricao) {
    final lowerTitulo = titulo.toLowerCase();
    final lowerDescricao = descricao.toLowerCase();

    for (var keyword in phishingKeywords) {
      if (lowerTitulo.contains(keyword) || lowerDescricao.contains(keyword)) {
        if (lowerTitulo.contains("urgente") || lowerDescricao.contains("suspensão")) {
          return "phishing";
        }
        return "possível phishing";
      }
    }
    return "seguro";
  }
}
