// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(something) => "\"Me interesa ${something}!\"";

  static String m1(something) => "Estoy muy interesado en ‘${something}’!";

  static String m2(lang) => "Solo escribe en ${lang}";

  static String m3(gender) =>
      "¿Cuál de ${Intl.gender(gender, female: 'sus', male: 'sus', other: 'sus')} ideas te gusta?";

  static String m4(country) => "Saltar, Solo ${country}";

  static String m5(country) => "¿Tienes planes de ir a ${country}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("Edad"),
        "block": MessageLookupByLibrary.simpleMessage("Bloquear"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "Bloquea a esta persona para no recibir mensajes de ella"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 No me hagas caso🔨🔨🔨 Solo estoy rompiendo el hielo🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("Copiar"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("Borrar"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Abrir Enlace"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("Reenviar"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("Deshacer match"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("Revisa sus perfiles"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Elegir"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Idiomas comúnmente usados"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Descripción (opcional)"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "doneButton": MessageLookupByLibrary.simpleMessage("Hecho"),
        "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
            "Error al enviar, por favor intente de nuevo más tarde."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "No enviado. SONA no traducirá palabras prohibidas."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA está sobrecargada, por favor intente de nuevo más tarde."),
        "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
        "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
            "SONA está buscando algunos amigos potenciales..."),
        "friendsIntention": MessageLookupByLibrary.simpleMessage(
            "Hola, creo que eres increíble. ¿Qué tal si nos hacemos amigos?"),
        "gore": MessageLookupByLibrary.simpleMessage("Gore"),
        "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
            "Oye, ¿adivina quién romperá el silencio primero?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("Deja que SONA diga hola"),
        "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
            "¿Qué opinas sobre la interpretación simultánea de IA?"),
        "iDigYourEnergy":
            MessageLookupByLibrary.simpleMessage("¡Me gusta tu energía!"),
        "iLikeYourStyle":
            MessageLookupByLibrary.simpleMessage("¡Me gusta tu estilo!"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("Intereses"),
        "interpretationOff": MessageLookupByLibrary.simpleMessage(
            "Interpretación Sincrónica de IA: Desactivada"),
        "interpretationOn": MessageLookupByLibrary.simpleMessage(
            "Interpretación Sincrónica de IA: Activada"),
        "justSendALike":
            MessageLookupByLibrary.simpleMessage("Solo Envía un Me Gusta"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou":
            MessageLookupByLibrary.simpleMessage("Deja que SONA te salude"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("Revisa sus perfiles"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "Estado: Aún sin me gusta\n\nQué hacer: Toma la iniciativa\n\nSugerencia: Sube tus fotos satisfactorias\nEscribe una biografía genuina\nElige tus intereses"),
        "likedYou": MessageLookupByLibrary.simpleMessage("Te gustó"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Encontrar extranjeros en la misma ciudad"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("Autorizar ubicación"),
        "matchPageSelectIdeas": m3,
        "nearby": MessageLookupByLibrary.simpleMessage("Cerca"),
        "newMatch":
            MessageLookupByLibrary.simpleMessage("¡Nueva coincidencia!"),
        "nextButton": MessageLookupByLibrary.simpleMessage("Próximo Paso"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "Estado: Sin mensajes\n\nSugerencia: Ve a la página de emparejamiento\n\nSugerencia: Haz un perfil increíble"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("Vaya, no hay datos ahora"),
        "other": MessageLookupByLibrary.simpleMessage("Otro"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "Las configuraciones de tu lista de deseos tendrán un papel más importante"),
        "personalAttack":
            MessageLookupByLibrary.simpleMessage("Ataque personal"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Por favor, revisa tu internet o Toca para Refrescar y prueba de nuevo"),
        "pornography": MessageLookupByLibrary.simpleMessage("Pornografía"),
        "preference": MessageLookupByLibrary.simpleMessage("Preferencia"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refrescar"),
        "report": MessageLookupByLibrary.simpleMessage("Informar"),
        "resendButton": MessageLookupByLibrary.simpleMessage("Reenviar"),
        "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
            "Encontrar extranjeros cerca de ti"),
        "scam": MessageLookupByLibrary.simpleMessage("Estafa"),
        "screenshotEvidence": MessageLookupByLibrary.simpleMessage(
            "Evidencia de captura de pantalla"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("Ver perfil"),
        "seeWhoLikeU":
            MessageLookupByLibrary.simpleMessage("Mira quién te gusta"),
        "selectCountryPageTitle":
            MessageLookupByLibrary.simpleMessage("Seleccionar País"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("Último paso"),
        "sonaInterpretationOff": MessageLookupByLibrary.simpleMessage(
            "⭕ SONA Int. Sincrónica desactivada"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Recomendación de Sona: Enfriamiento.\n¿Qué hacer?: Esperar.\n¿Sugerencia?: ¿Ver una película?"),
        "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
            "Ustedes hablan el mismo idioma"),
        "submitButton": MessageLookupByLibrary.simpleMessage("Enviar"),
        "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
            "👆 Están esperando tu respuesta"),
        "userAvatarOptionCamera":
            MessageLookupByLibrary.simpleMessage("Tomar una foto"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("Seleccionar de la galería"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("Cambiar"),
        "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
            "Un buen retrato te consigue más coincidencias. Sé real y usa una foto legítima de ti mismo."),
        "userAvatarPageTitle":
            MessageLookupByLibrary.simpleMessage("Muéstrate"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("¡Subida completada!"),
        "userBirthdayInputLabel":
            MessageLookupByLibrary.simpleMessage("Fecha de nacimiento"),
        "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Una vez confirmado, la nacionalidad no puede cambiar"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("Nacionalidad"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Género"),
        "userGenderOptionFemale":
            MessageLookupByLibrary.simpleMessage("Femenino"),
        "userGenderOptionMale":
            MessageLookupByLibrary.simpleMessage("Masculino"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("No binario"),
        "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Tu género no se mostrará públicamente, solo se usará para ayudar en la coincidencia"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Entrar"),
        "userInfoPageTitle":
            MessageLookupByLibrary.simpleMessage("Información básica"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Nombre"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("Número de Teléfono"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(""),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("política de privacidad"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage(" y "),
        "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
            "Al tocar \"Siguiente Paso\", aceptas nuestros "),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("términos de servicio"),
        "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
            "Introduzca el número de teléfono"),
        "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
            "Introduzca el código de verificación"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("¡Di hola!"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "Enlace externo. Verifica que la fuente sea confiable antes de pulsar, ya que los enlaces desconocidos pueden ser estafas o robar datos. Proceda con precaución."),
        "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Cuidado"),
        "warningUnmatching": MessageLookupByLibrary.simpleMessage(
            "Después de desemparejar, todo el historial de chat será eliminado."),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("Quién te gusta"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("Quién te gusta"),
        "wishActivityAddTitle":
            MessageLookupByLibrary.simpleMessage("Añade tu pensamiento"),
        "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Ayudarte a encontrar compañeros"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("¿Quieres hacer algo?"),
        "wishCityPickerSkipButton": m4,
        "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "si vas allí, ¿Qué ciudades quieres visitar?"),
        "wishCountryPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("país sientes más conexión?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("Qué"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("Tu deseo ha sido recibido"),
        "wishDateOptionHere":
            MessageLookupByLibrary.simpleMessage("Ya estoy aquí"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("Todavía no estoy seguro"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("Recientemente, supongo"),
        "wishDateOptionYear":
            MessageLookupByLibrary.simpleMessage("Dentro de un año"),
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Cuándo"),
        "wishList": MessageLookupByLibrary.simpleMessage("Lista de Deseos"),
        "wishes": MessageLookupByLibrary.simpleMessage("Deseo"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("Pareces genial")
      };
}
