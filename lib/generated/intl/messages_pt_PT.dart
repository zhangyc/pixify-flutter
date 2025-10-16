// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_PT locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt_PT';

  static String m0(month, day) => "${month}/${day}";

  static String m1(x) => "${x} dias para meta de 30 dias";

  static String m2(error) => "Falha ao obter análise de horóscopo: ${error}";

  static String m3(something) => "\"Estou interessado em ${something}!\"";

  static String m4(something) => "Estou muito interessado em ‘${something}’!";

  static String m5(lang) => "Basta digitar em ${lang}";

  static String m6(gender) =>
      "Qual das ${Intl.gender(gender, female: 'experiências de compartilhamento dela', male: 'experiências de compartilhamento dele', other: 'experiências de compartilhamento deles')} ressoa com você?";

  static String m7(minutes) => "${minutes} minutos";

  static String m8(month, day) => "${month}月${day}日";

  static String m9(score) => "Humor ${score}/10";

  static String m10(error) => "Falha ao obter análise da fase lunar: ${error}";

  static String m11(error) => "❌ Falha ao salvar: ${error}";

  static String m12(x) => "🔥 ${x} dias seguidos!";

  static String m13(storeName) =>
      "Ao clicar em \"Continuar\", será cobrado, a subscrição renovará automaticamente ao preço do pacote e poderá cancelar pela ${storeName}. Ao continuar, concorda com os nossos ";

  static String m14(count) =>
      "Desbloquear para ver ${count} usuários de alta correspondência ✨";

  static String m15(count, destinyCount) =>
      "Desbloquear ${count} usuários incluindo ${destinyCount} matches do destino ⭐";

  static String m16(country) => "Pular, Só ${country}";

  static String m17(country) => "Você está planejando ir para o ${country}";

  static String m18(x) => "${x} dias";

  static String m19(x) => "${x} horas";

  static String m20(x) => "${x} vezes";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1 meses"),
    "aYear": MessageLookupByLibrary.simpleMessage("1 ano"),
    "about": MessageLookupByLibrary.simpleMessage("Sobre"),
    "account": MessageLookupByLibrary.simpleMessage("Conta"),
    "active_days": MessageLookupByLibrary.simpleMessage("Dias Ativos"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Adicionar Foto"),
    "age": MessageLookupByLibrary.simpleMessage("Idade"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "IA criando fotos de grupo divertidas",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("Tudo"),
    "analyzingDailyHoroscope": MessageLookupByLibrary.simpleMessage(
      "Analisando horóscopo diário...",
    ),
    "analyzingMoonPhase": MessageLookupByLibrary.simpleMessage(
      "Analisando energia da fase lunar...",
    ),
    "analyzingText": MessageLookupByLibrary.simpleMessage("Analizando..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage(" Aquário"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("Áries"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage(
      "Signo Ascendente",
    ),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("Gráfico Astro"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "O outro usuário ainda não completou suas informações de local de nascimento, então não podemos gerar um gráfico astrológico. Por favor, aguarde até que eles completem suas informações.",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ Zena Interpretação Síncrona desligada",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Recomendação da Zena: Cooldown.\nO que fazer: Esperar.\nSugestão: Assistir a um filme?",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage(
          "Zena irá gerar uma biografia baseada nos teus interesses",
        ),
    "astroReport": MessageLookupByLibrary.simpleMessage("Relatório astro"),
    "astro_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Calendário de Cura Astrológica",
    ),
    "audio_1_desc": MessageLookupByLibrary.simpleMessage(
      "Encontre paz interior sob o céu estrelado silencioso",
    ),
    "audio_1_title": MessageLookupByLibrary.simpleMessage(
      "Meditação do Céu Estrelado",
    ),
    "audio_2_desc": MessageLookupByLibrary.simpleMessage(
      "Desperte sua coragem e vitalidade interior",
    ),
    "audio_2_title": MessageLookupByLibrary.simpleMessage(
      "Áudio de Energia de Áries",
    ),
    "audio_3_desc": MessageLookupByLibrary.simpleMessage(
      "Libere o estresse e encontre relaxamento completo",
    ),
    "audio_3_title": MessageLookupByLibrary.simpleMessage(
      "Guia de Relaxamento Profundo",
    ),
    "audio_4_desc": MessageLookupByLibrary.simpleMessage(
      "Equilibre emoções e encontre harmonia interior",
    ),
    "audio_4_title": MessageLookupByLibrary.simpleMessage(
      "Música de Equilíbrio Emocional",
    ),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao atualizar avatar",
    ),
    "average_mood": MessageLookupByLibrary.simpleMessage("Humor Médio"),
    "bio": MessageLookupByLibrary.simpleMessage("Introdução"),
    "birthInfo": MessageLookupByLibrary.simpleMessage(
      "Informações de Nascimento",
    ),
    "birthPlace": MessageLookupByLibrary.simpleMessage("Local de Nascimento"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage(
      "Local de Nascimento",
    ),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Hora de Nascimento",
    ),
    "birthday": MessageLookupByLibrary.simpleMessage("Aniversário"),
    "block": MessageLookupByLibrary.simpleMessage("Bloquear"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage(
          "Bloqueie essa pessoa para não receber mais mensagens dela",
        ),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage(
      "Aumentar o Charme",
    ),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 Não ligue para mim🔨🔨🔨 Estou só quebrando o gelo🔨🔨🔨",
    ),
    "breathe_relax": MessageLookupByLibrary.simpleMessage(
      "Respire fundo e relaxe...",
    ),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("És membro Plus"),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("Autorizar"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("Mudar"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("Continuar"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("Copiar"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("Apagar conta"),
    "buttonDone": MessageLookupByLibrary.simpleMessage("Concluído"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("Editar"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage("Editar perfil"),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("Gerar"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("Ir"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("Entendido"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage(
          "😪Zena cansada, 👇Toque pra recarregar!",
        ),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("Entrar Agora"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("Manter a conta"),
    "buttonManage": MessageLookupByLibrary.simpleMessage("Gerir"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("Próximo Passo"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Abrir Link"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("Pré-visualização"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("Comprar"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("Atualizar"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("Reenviar"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("Guardar"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("Terminar sessão"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("Submeter"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage(
      "Desbloquear benefícios VIP",
    ),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage(
      "Encerrar compartilhamento",
    ),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage(
      "Cancelar subscrição",
    ),
    "cancerSign": MessageLookupByLibrary.simpleMessage(" Câncer"),
    "capricornSign": MessageLookupByLibrary.simpleMessage(" Capricórnio"),
    "catchMore": MessageLookupByLibrary.simpleMessage("Pegue mais"),
    "charmTips": MessageLookupByLibrary.simpleMessage("Dicas de charme"),
    "chartPreview": MessageLookupByLibrary.simpleMessage("Prévia do Gráfico"),
    "chat": MessageLookupByLibrary.simpleMessage("Bate-papo"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage(
      "Chat ativamente com usuários correspondentes",
    ),
    "checkItOut": MessageLookupByLibrary.simpleMessage("Confira"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage(
      "Verifique os perfis deles",
    ),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Escolher"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Clique para definir local de nascimento",
    ),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage(
      "Clique para definir aniversário",
    ),
    "click_for_encouragement": MessageLookupByLibrary.simpleMessage(
      "Clique para encorajamento",
    ),
    "click_to_record_status": MessageLookupByLibrary.simpleMessage(
      "Clique para registrar status",
    ),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("Cerrar"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage(
      "Brincadeira! É grátis",
    ),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage(
      "Taxa do clube: \$99/mês",
    ),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "Entre no nosso clube exclusivo para benefícios incríveis",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage(
      "Entre no Clube",
    ),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("Língua principal"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Línguas comumente usadas",
    ),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage(
      "Comunicação",
    ),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage(
      "Compatibilidade",
    ),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage(
      "Complete informações astrológicas detalhadas",
    ),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Complete o seu perfil astro",
    ),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "Completar Perfil Astro",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "Complete suas informações de local de nascimento",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage("Completar Perfil"),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage(
      "Confirmar selecionar esta localização",
    ),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage(
      "Continuar com telefone",
    ),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "Coordenadas selecionadas atuais",
    ),
    "current_emotion": MessageLookupByLibrary.simpleMessage("Emoção Atual"),
    "dailyHoroscope": MessageLookupByLibrary.simpleMessage("Horóscopo Diário"),
    "dailyHoroscopeAnalysis": MessageLookupByLibrary.simpleMessage(
      "Análise de Horóscopo Diário",
    ),
    "dailyHoroscopeAnalysisRemark": MessageLookupByLibrary.simpleMessage(
      "Análise de horóscopo diário",
    ),
    "dailyHoroscopeTitle": MessageLookupByLibrary.simpleMessage(
      "Horóscopo Diário",
    ),
    "daily_quote": MessageLookupByLibrary.simpleMessage("Citação do Dia"),
    "daily_quotes_title": MessageLookupByLibrary.simpleMessage(
      "Citações Diárias",
    ),
    "daily_status": MessageLookupByLibrary.simpleMessage("Status Diário"),
    "date_format_md": m0,
    "days_to_30_goal": m1,
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage(
      "Informe de Análisis AI Profundo",
    ),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage(
      "Análise Profunda",
    ),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Análise Profunda de Sinastria",
    ),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage(
      "12:00 (Predeterminado)",
    ),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("Excluir Foto"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "Tem certeza de que deseja excluir esta foto? Esta ação não pode ser desfeita.",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage(
      "Descrição (opcional)",
    ),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("Match do Destino"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage(
      "Consumo de diamante falhou",
    ),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage(
      "Diamantes não são suficientes",
    ),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("Pacote de Diamantes"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("Baú de Diamantes"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage(
      "Presente de Diamantes",
    ),
    "diamondPack4": MessageLookupByLibrary.simpleMessage(
      "Pacote Grande de Diamantes",
    ),
    "diamondPack5": MessageLookupByLibrary.simpleMessage(
      "Pacote Supremo de Diamantes",
    ),
    "diamondStore": MessageLookupByLibrary.simpleMessage("Loja de Diamantes"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage(
      "Desbloqueie recursos premium com diamantes",
    ),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage(
      "Loja de Diamantes",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Aviso legal"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage(
      "Mostrar a minha cidade",
    ),
    "dm": MessageLookupByLibrary.simpleMessage("DM"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("Duo Snap"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage(
      "Duo Snap de qualquer forma",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Editar Perfil"),
    "emotion_analysis": MessageLookupByLibrary.simpleMessage(
      "Análise Emocional",
    ),
    "emotion_angry": MessageLookupByLibrary.simpleMessage("😠 Raiva"),
    "emotion_anxious": MessageLookupByLibrary.simpleMessage("😰 Ansioso"),
    "emotion_calm": MessageLookupByLibrary.simpleMessage("😌 Calmo"),
    "emotion_category": MessageLookupByLibrary.simpleMessage("Emoção"),
    "emotion_diary": MessageLookupByLibrary.simpleMessage("Diário de Emoções"),
    "emotion_diary_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Diário de emoções salvo",
    ),
    "emotion_diary_title": MessageLookupByLibrary.simpleMessage(
      "Diário de Emoções",
    ),
    "emotion_distribution": MessageLookupByLibrary.simpleMessage(
      "Distribuição de Emoções",
    ),
    "emotion_happy": MessageLookupByLibrary.simpleMessage("😊 Feliz"),
    "emotion_management": MessageLookupByLibrary.simpleMessage(
      "Gestão Emocional",
    ),
    "emotion_management_title": MessageLookupByLibrary.simpleMessage(
      "Gestão Emocional",
    ),
    "emotion_records": MessageLookupByLibrary.simpleMessage(
      "Registros de Emoção",
    ),
    "emotion_sad": MessageLookupByLibrary.simpleMessage("😢 Triste"),
    "emotion_subtitle": MessageLookupByLibrary.simpleMessage(
      "Entenda suas emoções e aprenda autocuidado",
    ),
    "emotion_tip": MessageLookupByLibrary.simpleMessage(
      "Aceite-se no momento presente, as emoções fluem como estrelas e eventualmente retornarão à paz",
    ),
    "emotion_tired": MessageLookupByLibrary.simpleMessage("😴 Cansado"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage(
      "Sensibilidade",
    ),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "Sua sala de chat privada ainda está vazia\nMas as estrelas sabem, a pessoa certa está vindo até você",
    ),
    "energy": MessageLookupByLibrary.simpleMessage("Energia"),
    "energy_category": MessageLookupByLibrary.simpleMessage("Energia"),
    "energy_index": MessageLookupByLibrary.simpleMessage("Índice de Energia"),
    "energy_level": MessageLookupByLibrary.simpleMessage("Nível de Energia"),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Digite o local de nascimento",
    ),
    "every_emotion_matters": MessageLookupByLibrary.simpleMessage(
      "Cada emoção merece ser vista e registrada",
    ),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage(
          "Não enviado. O Zena não traduzirá palavras proibidas.",
        ),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "Zena está sobrecarregada, por favor tente novamente mais tarde.",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "Falha no envio, por favor tente novamente mais tarde.",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage(
      "O destino está a caminho",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "Encontrar pessoas que partilham os teus interesses",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "Zena está encontrando alguns amigos em potencial...",
    ),
    "first_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Lua no primeiro quarto, bom momento para ação e decisões",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "Ei, eu acho você incrível. Que tal sermos amigos?",
    ),
    "full_moon_insight": MessageLookupByLibrary.simpleMessage(
      "Energia da lua cheia é mais forte, perfeita para liberar emoções",
    ),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("Futuro"),
    "geminiSign": MessageLookupByLibrary.simpleMessage(" Gêmeos"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage(
      "Obter Zena Plus",
    ),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage(
      "GIF não é permitido",
    ),
    "goDiscover": MessageLookupByLibrary.simpleMessage("Vá Descobrir"),
    "gotIt": MessageLookupByLibrary.simpleMessage("Entendi"),
    "great_keep_going": MessageLookupByLibrary.simpleMessage(
      "Ótimo! Continue assim ✨",
    ),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "Ei, adivinha quem vai quebrar o silêncio primeiro?",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage(
      "Deixe a Zena dizer oi",
    ),
    "healing_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Calendário de Cura Astral",
    ),
    "healing_category": MessageLookupByLibrary.simpleMessage("Cura"),
    "healing_count": MessageLookupByLibrary.simpleMessage("Sessões de Cura"),
    "healing_data": MessageLookupByLibrary.simpleMessage("Dados de Cura"),
    "healing_music_title": MessageLookupByLibrary.simpleMessage(
      "Música de Cura",
    ),
    "healing_sessions": MessageLookupByLibrary.simpleMessage("Sessões de Cura"),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "Isto foi feito pela Zena para ti",
    ),
    "horoscopeAnalysisError": m2,
    "horoscopeFetchFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao buscar horóscopo",
    ),
    "horoscopeRemark": MessageLookupByLibrary.simpleMessage(
      "Análise de horóscopo diário",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
      "O que pensa sobre a interpretação simultânea por IA?",
    ),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage(
      "Gosto da sua energia!",
    ),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage(
      "Eu gosto do seu estilo!",
    ),
    "imInterestedSomething": m3,
    "imVeryInterestedInSomething": m4,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage(
      "Informações de aniversário do usuário estão incompletas",
    ),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Informação Incompleta",
    ),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage(
      "Intelectual",
    ),
    "interests": MessageLookupByLibrary.simpleMessage("Interesses"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage(
      "Interpretação Síncrona AI: Desligada",
    ),
    "interpretationOn": MessageLookupByLibrary.simpleMessage(
      "Interpretação Síncrona AI: Ligada",
    ),
    "issues": MessageLookupByLibrary.simpleMessage("Problemas"),
    "justNow": MessageLookupByLibrary.simpleMessage("Agora mesmo"),
    "justSendALike": MessageLookupByLibrary.simpleMessage(
      "Apenas Compartilhe sua Apreciação",
    ),
    "justTypeInYourLanguage": m5,
    "keep_it_up": MessageLookupByLibrary.simpleMessage(
      "Continue assim! Você está indo muito bem ✨",
    ),
    "last_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Lua no último quarto, deixe o passado para trás e prepare-se para novos começos",
    ),
    "leoSign": MessageLookupByLibrary.simpleMessage("Leão"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "Deixe a Zena dizer oi por você",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("Libra"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage(
      "Estilo de Vida",
    ),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Análisis AI Ligero",
    ),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Análise de Sinastria",
    ),
    "likeBack": MessageLookupByLibrary.simpleMessage("Curta de volta"),
    "likedBack": MessageLookupByLibrary.simpleMessage("Já curtiu de volta"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage(
      "Conheça seu compartilhamento",
    ),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "Status: Ainda sem apreciações\n\nO que fazer: Comece a compartilhar\n\nSugestão:\nRetratos autênticos\nHistórias genuínas\nInteresses compartilhados conectam\n\nQuero dizer...\nFaça o upload de suas fotos reais\nCompartilhe sua história autêntica\nEscolha seus interesses",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage(
      "Aprecia seu compartilhamento",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Carregando..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "Precisamos da sua localização para mostrar pessoas próximas",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao obter localização",
    ),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Localizado na posição atual",
    ),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "Precisamos da sua localização para melhorar a sua experiência social",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Autorizar localização",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage(
      "Localização selecionada no mapa",
    ),
    "matchPageSelectIdeas": m6,
    "me": MessageLookupByLibrary.simpleMessage("Eu"),
    "meditation_category": MessageLookupByLibrary.simpleMessage("Meditação"),
    "meditation_count": MessageLookupByLibrary.simpleMessage(
      "Contagem de Meditação",
    ),
    "meditation_practice": MessageLookupByLibrary.simpleMessage(
      "Prática de Meditação",
    ),
    "meditation_practice_title": MessageLookupByLibrary.simpleMessage(
      "Prática de Meditação",
    ),
    "meditation_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Registro de meditação salvo",
    ),
    "meditation_subtitle": MessageLookupByLibrary.simpleMessage(
      "Encontre paz interior através da meditação astral",
    ),
    "memberCenter": MessageLookupByLibrary.simpleMessage("Centro de Membros"),
    "membersPerks": MessageLookupByLibrary.simpleMessage(
      "Os membros recebem benefícios exclusivos",
    ),
    "minutes_duration": m7,
    "month": MessageLookupByLibrary.simpleMessage("Mês"),
    "month_day_format": m8,
    "mood": MessageLookupByLibrary.simpleMessage("Humor"),
    "mood_index": MessageLookupByLibrary.simpleMessage("Índice de Humor"),
    "mood_score": m9,
    "moonPhaseAnalysis": MessageLookupByLibrary.simpleMessage(
      "Análise da Fase Lunar",
    ),
    "moonPhaseAnalysisError": m10,
    "moonPhaseAnalysisRemark": MessageLookupByLibrary.simpleMessage(
      "Análise de energia da fase lunar",
    ),
    "moonPhaseAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Análise de Energia da Fase Lunar",
    ),
    "moonPhaseEnergy": MessageLookupByLibrary.simpleMessage(
      "Energia da Fase Lunar",
    ),
    "moonPhaseFetchFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao buscar fase lunar",
    ),
    "moonPhaseRemark": MessageLookupByLibrary.simpleMessage(
      "Análise de energia da fase lunar",
    ),
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
      "Quanto mais fotos, maior o valor de recomendação",
    ),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage(
      "Mais fotos, Mais charme!",
    ),
    "music_subtitle": MessageLookupByLibrary.simpleMessage(
      "Áudio astral relaxante para mente e corpo",
    ),
    "myPhotos": MessageLookupByLibrary.simpleMessage("Minhas Fotos"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("Meu Perfil"),
    "my_statistics": MessageLookupByLibrary.simpleMessage(
      "Minhas Estatísticas",
    ),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Pular para página de perfil astro",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("Perto"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("Nova jogabilidade"),
    "newMatch": MessageLookupByLibrary.simpleMessage("Nova Conexão!"),
    "new_moon_insight": MessageLookupByLibrary.simpleMessage(
      "Momento da lua nova, perfeito para iniciar novos planos de cura",
    ),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage(
      "Próxima data de pagamento",
    ),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "Status: Sem mensagens\n\nO que fazer: Encontre ouvintes\n\nSugestão: Compartilhe sua autenticidade",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage(
      "Ainda ninguém encontrou o seu charme",
    ),
    "noThanks": MessageLookupByLibrary.simpleMessage("Não, obrigado"),
    "no_audio": MessageLookupByLibrary.simpleMessage("Sem áudio disponível"),
    "no_quotes": MessageLookupByLibrary.simpleMessage(
      "Sem citações disponíveis",
    ),
    "no_records_today": MessageLookupByLibrary.simpleMessage(
      "Nenhum registro para este dia",
    ),
    "notes": MessageLookupByLibrary.simpleMessage("Notas"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notificações"),
    "onboarding0": MessageLookupByLibrary.simpleMessage(
      "Zena é como uma base de casa para cidadãos do mundo",
    ),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "Quer em casa ou na estrada, conhece pessoas de todo o mundo. E...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "Ganharás um superpoder: \nDomínio das línguas Sem mais barreiras de comunicação",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "Fala menos, ama mais. Uma romântica\nlenda espera por ti",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage(
      "Por favor, completa a lista de\ndesejos para obteres um par mais ideal",
    ),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage(
      "Uma frase para conquistar",
    ),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage(
      "Ops, sem dados agora",
    ),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage(
          "As configurações da sua lista de desejos terão um papel maior",
        ),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Precisamos desta permissão para lhe proporcionar a melhor experiência",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Permissão Necessária",
    ),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage(
      "Completar perfil básico",
    ),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Complete nome, aniversário, gênero para desbloquear mais recomendações",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "Ativar notificações de mensagem",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "Não perca matches e mensagens, interaja a tempo",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("Para você"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage(
      "Mostrar sua cidade",
    ),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage(
      "Mais fácil de ser descoberto por usuários locais",
    ),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage(
      "Enviar suas fotos",
    ),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      "Adicione pelo menos 2 fotos claras para aumentar a exposição",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage("Tirar uma foto"),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage(
      "Selecionar da galeria",
    ),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage(
      "Esta foto pode não ser real",
    ),
    "photos": MessageLookupByLibrary.simpleMessage("Fotos"),
    "piscesSign": MessageLookupByLibrary.simpleMessage(" Peixes"),
    "played_audio": MessageLookupByLibrary.simpleMessage("Áudio reproduzido"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Por favor, verifique sua internet ou Toque para Atualizar e tente novamente",
        ),
    "please_write_feelings": MessageLookupByLibrary.simpleMessage(
      "Por favor escreva seus sentimentos",
    ),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "Lembretes de atividade e retorno",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "Ordenar por atividade recente e taxa de resposta",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "Filtros avançados: país/idioma/fuso horário/cidade",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "Proteção prioritária contra assédio e proteção de peso",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "Pontos de conflito e conselhos de relacionamento",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "Exposição prioritária do destino em recomendações e curtidas",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage(
      "Notificações de chegada de novo match do destino",
    ),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "Quebra de 4 dimensões: personalidade/comunicação/intimidade/fronteiras",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "Exibição de pontuação alta com porcentagem",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "Tradução de histórico de mensagens com um clique",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "Filtros de interesse e plano de viagem",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "Lembretes de curtir de volta e confirmação de leitura",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "Visualização da pontuação geral de compatibilidade",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "Modelos de mensagem rápida (elogios/convites/mudança de plataforma)",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "Tradução instantânea de imagem e reconhecimento de texto",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "Tradução e polimento em tempo real: correção automática multilíngue",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "Linhas de abertura inteligentes: 3 sugestões de alta conversão por pessoa",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "Pacote de saudação estelar: 10 saudações diárias",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "Resolução acelerada de problemas de assinatura",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "Piscina de tópicos de conversa baseada na análise de perfil",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "Desbloquear avatares e tags claros em Curtiu-me",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Descrição Plus"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "1000 interpretações simultâneas/dia",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - O teu conselheiro de chat",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage(
      "5 DM por semana",
    ),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "Filtrar países de conexão",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Gostos ilimitados",
    ),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Desbloquear para ver quem aprecia seu compartilhamento",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3 desejos"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Membro Plus"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "Benefícios da Assinatura Plus",
    ),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage(
      "Duo Snap com Plus",
    ),
    "practice_count": MessageLookupByLibrary.simpleMessage(
      "Contagem de Práticas",
    ),
    "preference": MessageLookupByLibrary.simpleMessage("Preferência"),
    "privacy": MessageLookupByLibrary.simpleMessage("Privacidade"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "productNotFound": MessageLookupByLibrary.simpleMessage(
      "Producto no encontrado",
    ),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("Perfil"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage(
      "Ainda não mostraram o seu verdadeiro eu",
    ),
    "profileTip": MessageLookupByLibrary.simpleMessage(
      "✨ Complete seu perfil para que as estrelas possam conhecê-lo melhor, para um matching mais preciso",
    ),
    "psychological_healing": MessageLookupByLibrary.simpleMessage(
      "Cura Psicológica",
    ),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage("Compra Falhou"),
    "purchasePending": MessageLookupByLibrary.simpleMessage("Compra Pendente"),
    "pushNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificações push",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Ações Rápidas"),
    "quote_1": MessageLookupByLibrary.simpleMessage(
      "Você brilha como uma estrela hoje",
    ),
    "quote_10": MessageLookupByLibrary.simpleMessage(
      "Encontre respostas nos momentos quietos",
    ),
    "quote_2": MessageLookupByLibrary.simpleMessage(
      "Confie em si mesmo como confia nas estrelas",
    ),
    "quote_3": MessageLookupByLibrary.simpleMessage(
      "Cada um é uma constelação única",
    ),
    "quote_4": MessageLookupByLibrary.simpleMessage(
      "A energia do universo está com você",
    ),
    "quote_5": MessageLookupByLibrary.simpleMessage(
      "Aceite-se como você é agora",
    ),
    "quote_6": MessageLookupByLibrary.simpleMessage(
      "Toda emoção merece ser vista",
    ),
    "quote_7": MessageLookupByLibrary.simpleMessage(
      "Deixe a energia estelar fluir através de você",
    ),
    "quote_8": MessageLookupByLibrary.simpleMessage(
      "Hoje é novo com possibilidades infinitas",
    ),
    "quote_9": MessageLookupByLibrary.simpleMessage(
      "Sua existência é um milagre em si",
    ),
    "quotes_subtitle": MessageLookupByLibrary.simpleMessage(
      "Energia curativa das estrelas",
    ),
    "record_daily_status": MessageLookupByLibrary.simpleMessage(
      "Registrar Status Diário",
    ),
    "record_today_hint": MessageLookupByLibrary.simpleMessage(
      "O que você gostaria de registrar hoje?",
    ),
    "record_your_feelings": MessageLookupByLibrary.simpleMessage(
      "Registre seus sentimentos",
    ),
    "recorded_days": MessageLookupByLibrary.simpleMessage("Dias Registrados"),
    "recorded_emotion": MessageLookupByLibrary.simpleMessage(
      "Emoção registrada",
    ),
    "relaxation_category": MessageLookupByLibrary.simpleMessage("Relaxamento"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 Lembre-os de enviar fotos, conheçam-se melhor",
    ),
    "report": MessageLookupByLibrary.simpleMessage("Relatar"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("Gore"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("Outro"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "Ataque pessoal",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage(
      "Ataque pessoal",
    ),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage(
      "Pornografia",
    ),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("Fraude"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage(
      "Precisamos da sua foto real",
    ),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "Encontrando estrangeiros perto de você",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage(" Sagitário"),
    "save": MessageLookupByLibrary.simpleMessage("Salvar"),
    "save_failed": m11,
    "scorpioSign": MessageLookupByLibrary.simpleMessage(" Escorpião"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage(
      "Evidência de captura de tela",
    ),
    "seeProfile": MessageLookupByLibrary.simpleMessage("Ver perfil"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage(
      "Veja quem aprecia você",
    ),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Selecionar Local de Nascimento",
    ),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage(
      "Selecione sua data de nascimento para ver seu gráfico astrológico",
    ),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage(
      "Selecionar País",
    ),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Selecionar Localização",
    ),
    "select_duration_start": MessageLookupByLibrary.simpleMessage(
      "Selecione a duração para iniciar a meditação",
    ),
    "select_meditation_duration": MessageLookupByLibrary.simpleMessage(
      "Selecione a duração da meditação",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("Enviar DM"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("Enviar Mensagem DM"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 Envie uma saudação estelar para desbloquear álbum Continuar",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage("Definir como padrão"),
    "setInterestTags": MessageLookupByLibrary.simpleMessage(
      "Defina tags de interesse claras",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Definições"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage(
      "Mostra a tua perZenalidade",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage(
      "Mostre sua personalidade",
    ),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage(
      "Prestes a terminar",
    ),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6 meses"),
    "sleep_category": MessageLookupByLibrary.simpleMessage("Sono"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
      "Vocês falam a mesma língua",
    ),
    "spiritual_growth": MessageLookupByLibrary.simpleMessage(
      "Crescimento Espiritual",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Padrão"),
    "startChat": MessageLookupByLibrary.simpleMessage("Iniciar chat"),
    "start_meditation": MessageLookupByLibrary.simpleMessage(
      "Iniciar Meditação",
    ),
    "startedChat": MessageLookupByLibrary.simpleMessage("Iniciou chat com"),
    "status_saved": MessageLookupByLibrary.simpleMessage("✅ Status salvo"),
    "stop_meditation": MessageLookupByLibrary.simpleMessage("Parar Meditação"),
    "streak_days": MessageLookupByLibrary.simpleMessage("Dias Consecutivos"),
    "streak_x_days": m12,
    "stress": MessageLookupByLibrary.simpleMessage("Estresse"),
    "stress_index": MessageLookupByLibrary.simpleMessage("Índice de Estresse"),
    "stress_level": MessageLookupByLibrary.simpleMessage("Nível de Estresse"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage(
          "1000 \ninterpretações \nsimultâneas/dia",
        ),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - \nO teu conselheiro de chat",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage(
      "5 DM por semana",
    ),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage("Filtrar países de \nconexão"),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Gostos ilimitados",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Desbloquear para \nver quem aprecia você",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("Obter Zena Plus"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage(
      "Termos e Condições",
    ),
    "subscriptionAgreementPrefix": m13,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage("."),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("Signo Solar"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("Análise"),
    "takeIt": MessageLookupByLibrary.simpleMessage("Utilizar"),
    "taurusSign": MessageLookupByLibrary.simpleMessage(" Touro"),
    "termsOfService": MessageLookupByLibrary.simpleMessage("Termos de Serviço"),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage(
      "A chave é o equilíbrio",
    ),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 Eles estão esperando sua resposta",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3 meses"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀Atingiste o teu limite diário",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅Atingiste o teu limite semanal",
    ),
    "toggle_background_music": MessageLookupByLibrary.simpleMessage(
      "Alternar Música de Fundo",
    ),
    "total_duration": MessageLookupByLibrary.simpleMessage("Duração Total"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("Desconhecido"),
    "unlockDailyHoroscope": MessageLookupByLibrary.simpleMessage(
      "Desbloquear horóscopo detalhado do zodíaco",
    ),
    "unlockHighMatchUsers": m14,
    "unlockMoonPhaseInsight": MessageLookupByLibrary.simpleMessage(
      "Desbloquear insight de energia da fase lunar de hoje",
    ),
    "unlockUsersWithDestiny": m15,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "Preços especiais imperdíveis",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage(
      "Plataforma no compatible",
    ),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "Upgrade para Premium para mais recomendações",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage(
      "Carregue fotos reais de alta qualidade",
    ),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage(
      "Carregue sua foto",
    ),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage(
      "Carregue sua melhor foto",
    ),
    "uploading": MessageLookupByLibrary.simpleMessage("Carregando..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Usar localização atual",
    ),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage(
      "Tirar uma foto",
    ),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage(
      "Selecionar da galeria",
    ),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Um bom retrato ajuda você a se conectar com mais ouvintes. Seja real e use uma foto legítima de você mesmo.",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("Mostre-se"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage(
      "Upload concluído!",
    ),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage(
      "Dia de nascimento",
    ),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Uma vez confirmado, a nacionalidade não pode ser alterada",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Nacionalidade",
    ),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Gênero"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("Feminino"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("Masculino"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage(
      "Não-binário",
    ),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Seu gênero não será mostrado ao público, será usado apenas para ajudar na conexão",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Entrar",
    ),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage(
      "Informação básica",
    ),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Nome"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Número de Telefone",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      " ",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "política de privacidade",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage(" e "),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "Ao tocar em \"Próxima Etapa\", você concorda com nossos ",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "termos de serviço",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
      "Digite o número de telefone",
    ),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("Valores"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
      "Digite o código de verificação",
    ),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage(
      "Ver relatório astro com",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("Ver Detalhes"),
    "virgoSign": MessageLookupByLibrary.simpleMessage(" Virgem"),
    "waning_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "Momento da lua minguante, descanso e recuperação são importantes",
    ),
    "waning_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "Lua está minguando, bom momento para reflexão e organização",
    ),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage(
      "Gostaria de compartilhar...",
    ),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "Após fechar, a sua cidade não será exibida durante o emparelhamento",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "A sua conta será automaticamente eliminada em 14 dias. Por favor, lembre-se de ir à loja para cancelar a sua subscrição atual para evitar encargos adicionais.",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Se eliminar a sua conta, não poderá mais fazer login com ela. Tem a certeza de que quer eliminar?",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "Ligação externa. Verifique se a fonte é confiável antes de clicar, pois links desconhecidos podem ser fraudes ou roubar dados. Proceda com cautela.",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Cautela"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "Após encerrar o compartilhamento, todo o histórico de conversa será apagado.",
    ),
    "waxing_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "Lua está crescendo, energia está se acumulando gradualmente",
    ),
    "waxing_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "Lua cheia se aproximando, emoções podem estar mais sensíveis",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage(
      "Qual é o seu email?",
    ),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage(
      "Quem aprecia seu compartilhamento",
    ),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("Quem aprecia você"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage(
      "Adicione seu pensamento",
    ),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ajudar a encontrar companheiros",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Quer fazer alguma coisa?",
    ),
    "wishCityPickerSkipButton": m16,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "se você for lá, Quais cidades você quer visitar?",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Em que país estás mais interessado?",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
      "Seu desejo foi recebido",
    ),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Já estou aqui"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage(
      "Ainda não tenho certeza",
    ),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage(
      "Recentemente, eu acho",
    ),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage(
      "Dentro de um ano",
    ),
    "wishDatePickerSubtitle": m17,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Quando"),
    "wishList": MessageLookupByLibrary.simpleMessage("Lista de Desejos"),
    "wishes": MessageLookupByLibrary.simpleMessage("Desejo"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage(
      "Escreva uma biografia pessoal interessante",
    ),
    "write_feelings_hint": MessageLookupByLibrary.simpleMessage(
      "Escreva como você se sente...",
    ),
    "x_days": m18,
    "x_hours": m19,
    "x_times": m20,
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage(
      "Agora és membro do clube",
    ),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage(
      "Podes editá-lo a qualquer momento",
    ),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("Você parece legal"),
  };
}
