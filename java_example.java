    @Override
    public UserExtLoginParseVo parseOpenId(String token){
        
        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), GsonFactory.getDefaultInstance())
                //这里传入刚才前期准备的客户端ID，这里可以是个数组，因为咱们安卓和IOS是分开的。
                .setAudience(Arrays.asList(
                        "972955903429-61qp69hlgjsok21jn6tnahqjc2ojmvc8.apps.googleusercontent.com", // android debug
                        "972955903429-vt1uhbhnum92lqr96tnao5c1bi48prur.apps.googleusercontent.com", // android release
                        "972955903429-b0red9vteokuac6bco999dl0ftlfe42o.apps.googleusercontent.com" // ios
                )).build();
        try {
            GoogleIdToken idToken = verifier.verify(token);
            if(idToken == null){
                return null;
            }
            GoogleIdToken.Payload payload = idToken.getPayload();
            if(payload == null){
                return null;
            }
            return UserExtLoginParseVo.create(payload.getEmail(),payload.getSubject());
        }catch (Exception e){
            log.error("google 验证报错",e);
        }
        return null;
    }
