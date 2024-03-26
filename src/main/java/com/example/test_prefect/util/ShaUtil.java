package com.example.test_prefect.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;


public class ShaUtil {
	public static String generateSalt() { // 메소드는 솔트를 생성하여 문자열로 반환합니다.
        SecureRandom random; // salt 생성시에 사용되는 난수 생성기 메소드 SecureRandom 는 그냥 무작위 숫자가 아닌 보안에 강력한 무작위 숫자를 생성한다.
        try {
            random = SecureRandom.getInstance("SHA1PRNG"); // SHA1PRNG 알고리즘의 SecureRandom 객체를 가져옵니다. 이 알고리즘은 무작위 숫자를 생성하기 위한 알고리즘 중 하나입니다.
            byte[] bytes = new byte[16]; //16바이트 크기의 bytes 배열을 생성
            random.nextBytes(bytes); //SecureRandom 객체로부터 무작위 바이트를 생성하여 bytes 배열에 저장합니다.
            return new String(Base64.getEncoder().encode(bytes)); // 사용하여 바이트 배열을 Base64로 인코딩합니다. Base64는 바이너리 데이터를 텍스트 형식으로 변환하는 인코딩 방식 중 하나입니다.

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String hash(String input) {  //문자열의 입력을 받는다
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256"); // SHA-256알고리즘의 MessageDigest 객체를 가져옴 => 해시 계산하는 명령
            md.update(input.getBytes()); //입력받은 값을 해시해준다
            return String.format("%064x", new BigInteger(1, md.digest())); //16진수 문자열로 변환,여기서 "%064x"는 16진수를 64자리로 포맷팅하는 것을 의미함.
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();  //지정된 해시 알고리즘이 존재하지 않을 경우에는 e.printStackTrace()를 호출하여 예외 상황을 출력하고, 메소드는 null을 반환
            return null;
        }
    }

 //밑은 JUnitTest용 코드
    public void saltGeneration() {  //salt 생성
        String salt = ShaUtil.generateSalt();
    }

    public void hashingWithoutSalt() throws NoSuchAlgorithmException { //Salt 없이 해싱
        String raw = "test1";
        String hex = ShaUtil.hash(raw);

    }

    public void hashingWithSalt() throws NoSuchAlgorithmException { //salt와 함께 해싱
        String raw = "test1";
        String salt = ShaUtil.generateSalt();
        String rawAndSalt = raw + salt;
        String hex = ShaUtil.hash(rawAndSalt);

    }
	}
