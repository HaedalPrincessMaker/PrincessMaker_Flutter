import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future kakaoLogin() async {
  OAuthToken token;
  // 카카오톡 실행 가능 여부 확인
// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      token = await UserApi.instance.loginWithKakaoAccount();
      String scopes = token.scopes!.join(', ');
      print('카카오톡으로 로그인 성공'
          '\n엑세스 토큰: ${token.accessToken}'
          '\n엑세스 토큰 만료 시간: ${token.expiresAt}'
          '\n리프레시 토큰: ${token.refreshToken}'
          '\n리프레시 토큰 만료 시간: ${token.refreshTokenExpiresAt}'
          '\n허용된 범위: ${scopes}'
          '\nID 토큰: ${token.idToken}');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        String scopes = token.scopes!.join(', ');
        print('카카오계정으로 로그인 성공'
            '\n엑세스 토큰: ${token.accessToken}'
            '\n엑세스 토큰 만료 시간: ${token.expiresAt}'
            '\n리프레시 토큰: ${token.refreshToken}'
            '\n리프레시 토큰 만료 시간: ${token.refreshTokenExpiresAt}'
            '\n허용된 범위: ${scopes}'
            '\nID 토큰: ${token.idToken}');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }

  //-------------------------------------------------------------------------------
  User user;
  try {
    user = await UserApi.instance.me();
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
    return;
  }

  // 사용자의 추가 동의가 필요한 사용자 정보 동의항목 확인
  List<String> scopes = [];

  if (user.kakaoAccount?.profileNeedsAgreement == true) {
    scopes.add("profile");
  }

  if (scopes.length > 0) {
    print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

    // OpenID Connect 사용 시
    // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
    // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
    // scopes.add("openid")

    // scope 목록을 전달하여 추가 항목 동의 받기 요청
    // 지정된 동의항목에 대한 동의 화면을 거쳐 다시 카카오 로그인 수행
    OAuthToken token;
    try {
      token = await UserApi.instance.loginWithNewScopes(scopes);
      print('현재 사용자가 동의한 동의항목: ${token.scopes}');
    } catch (error) {
      print('추가 동의 요청 실패 $error');
      return;
    }

    // 사용자 정보 재요청
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }
}