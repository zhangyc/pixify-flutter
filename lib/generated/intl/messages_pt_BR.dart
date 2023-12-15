// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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
  String get localeName => 'pt_BR';

  static String m0(something) => "\"Estou interessado em ${something}!\"";

  static String m1(something) => "Estou muito interessado em ‘${something}’!";

  static String m2(lang) => "Basta digitar em ${lang}";

  static String m3(gender) =>
      "Qual das ${Intl.gender(gender, female: 'ideias dela', male: 'ideias dele', other: 'ideias deles')} você gosta?";

  static String m4(country) => "Pular, Só ${country}";

  static String m5(country) => "Você está planejando ir para o ${country}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("Idade"),
        "block": MessageLookupByLibrary.simpleMessage("Bloquear"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "Bloqueie essa pessoa para não receber mais mensagens dela"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 Não ligue para mim🔨🔨🔨 Só estou quebrando o gelo🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("Copiar"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("Apagar"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Abrir Link"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("Reenviar"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("Desfazer match"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "chat": MessageLookupByLibrary.simpleMessage("Bate-papo"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("Verifique os perfis deles"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Escolher"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Línguas comumente usadas"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Descrição (opcional)"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "doneButton": MessageLookupByLibrary.simpleMessage("Concluído"),
        "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
            "Falha ao enviar, por favor tente novamente mais tarde."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "Não enviado. O SONA não traduzirá palavras proibidas."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA está sobrecarregada, por favor tente novamente mais tarde."),
        "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
        "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
            "SONA está encontrando alguns amigos em potencial..."),
        "friendsIntention": MessageLookupByLibrary.simpleMessage(
            "Ei, acho você incrível. Que tal sermos amigos?"),
        "gore": MessageLookupByLibrary.simpleMessage("Gore"),
        "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
            "Ei, adivinha quem vai quebrar o silêncio primeiro?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("Deixe a SONA dizer oi"),
        "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
            "O que você acha da interpretação simultânea por IA?"),
        "iDigYourEnergy":
            MessageLookupByLibrary.simpleMessage("Gosto da sua energia!"),
        "iLikeYourStyle":
            MessageLookupByLibrary.simpleMessage("Eu gosto do seu estilo!"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("Interesses"),
        "interpretationOff": MessageLookupByLibrary.simpleMessage(
            "Interpretação Síncrona AI: Desligada"),
        "interpretationOn": MessageLookupByLibrary.simpleMessage(
            "Interpretação Síncrona AI: Ligada"),
        "justSendALike":
            MessageLookupByLibrary.simpleMessage("Apenas Envie um Like"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou": MessageLookupByLibrary.simpleMessage(
            "Deixe a SONA dizer oi por você"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("Verifique os perfis deles"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "Status: Ainda sem curtidas\n\nO que fazer: Tome a iniciativa\n\nSugestão: \nFaça o upload de suas fotos satisfatórias\nEscreva uma biografia genuína\nEscolha seus interesses"),
        "likedYou": MessageLookupByLibrary.simpleMessage("Gostou de você"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Encontrar estrangeiros na mesma cidade"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("Autorizar localização"),
        "matchPageSelectIdeas": m3,
        "nearby": MessageLookupByLibrary.simpleMessage("Perto"),
        "newMatch": MessageLookupByLibrary.simpleMessage("Novo Correspondido!"),
        "nextButton": MessageLookupByLibrary.simpleMessage("Próxima Etapa"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "Status: Sem mensagens\n\nSugestão: Vá para a página de emparelhamento\n\nSugestão: Faça um perfil incrível"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("Ops, sem dados agora"),
        "other": MessageLookupByLibrary.simpleMessage("Outro"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "As configurações da sua lista de desejos terão um papel maior"),
        "personalAttack":
            MessageLookupByLibrary.simpleMessage("Ataque pessoal"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Por favor, verifique sua internet ou Toque para Atualizar e tente novamente"),
        "pornography": MessageLookupByLibrary.simpleMessage("Pornografia"),
        "preference": MessageLookupByLibrary.simpleMessage("Preferência"),
        "refresh": MessageLookupByLibrary.simpleMessage("Atualizar"),
        "report": MessageLookupByLibrary.simpleMessage("Relatar"),
        "resendButton": MessageLookupByLibrary.simpleMessage("Reenviar"),
        "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
            "Encontrando estrangeiros perto de você"),
        "scam": MessageLookupByLibrary.simpleMessage("Fraude"),
        "screenshotEvidence": MessageLookupByLibrary.simpleMessage(
            "Evidência de captura de tela"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("Ver perfil"),
        "seeWhoLikeU":
            MessageLookupByLibrary.simpleMessage("Veja quem gosta de você"),
        "selectCountryPageTitle":
            MessageLookupByLibrary.simpleMessage("Selecionar País"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("Último passo"),
        "sonaInterpretationOff": MessageLookupByLibrary.simpleMessage(
            "⭕ SONA Interpretação Síncrona desligada"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Recomendação da Sona: Cooldown.\nO que fazer: Esperar.\nSugestão: Assistir a um filme?"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("Vocês falam a mesma língua"),
        "submitButton": MessageLookupByLibrary.simpleMessage("Submeter"),
        "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
            "👆 Eles estão esperando sua resposta"),
        "userAvatarOptionCamera":
            MessageLookupByLibrary.simpleMessage("Tirar uma foto"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("Selecionar da galeria"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("Mudar"),
        "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
            "Um bom retrato lhe dá mais correspondências. Seja real e use uma foto legítima de você mesmo."),
        "userAvatarPageTitle":
            MessageLookupByLibrary.simpleMessage("Mostre-se"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("Upload concluído!"),
        "userBirthdayInputLabel":
            MessageLookupByLibrary.simpleMessage("Dia de nascimento"),
        "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Uma vez confirmado, a nacionalidade não pode ser alterada"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("Nacionalidade"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Gênero"),
        "userGenderOptionFemale":
            MessageLookupByLibrary.simpleMessage("Feminino"),
        "userGenderOptionMale":
            MessageLookupByLibrary.simpleMessage("Masculino"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("Não-binário"),
        "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Seu gênero não será mostrado ao público, será usado apenas para ajudar na combinação"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Entrar"),
        "userInfoPageTitle":
            MessageLookupByLibrary.simpleMessage("Informação básica"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Nome"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("Número de Telefone"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(""),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("política de privacidade"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage(" e "),
        "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
            "Ao tocar em \"Próxima Etapa\", você concorda com nossos "),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("termos de serviço"),
        "userPhoneNumberPageTitle":
            MessageLookupByLibrary.simpleMessage("Insira o número de telefone"),
        "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
            "Insira o código de verificação"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("Diga olá!"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "Link externo. Verifique se a fonte é confiável antes de clicar, pois links desconhecidos podem ser fraudes ou roubar dados. Proceda com cautela."),
        "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Cautela"),
        "warningUnmatching": MessageLookupByLibrary.simpleMessage(
            "Após desfazer o emparelhamento, todo o histórico de chat será apagado."),
        "whoLIkesYou":
            MessageLookupByLibrary.simpleMessage("Quem gosta de você"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("Quem gosta de você"),
        "wishActivityAddTitle":
            MessageLookupByLibrary.simpleMessage("Adicione seu pensamento"),
        "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Ajudar a encontrar companheiros"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("Quer fazer alguma coisa?"),
        "wishCityPickerSkipButton": m4,
        "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "se você for lá, Quais cidades você quer visitar?"),
        "wishCountryPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "país você se identifica mais?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("Qual"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("Seu desejo foi recebido"),
        "wishDateOptionHere":
            MessageLookupByLibrary.simpleMessage("Já estou aqui"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("Ainda não tenho certeza"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("Recentemente, eu acho"),
        "wishDateOptionYear":
            MessageLookupByLibrary.simpleMessage("Dentro de um ano"),
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Quando"),
        "wishList": MessageLookupByLibrary.simpleMessage("Lista de Desejos"),
        "wishes": MessageLookupByLibrary.simpleMessage("Desejo"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("Você parece legal")
      };
}
