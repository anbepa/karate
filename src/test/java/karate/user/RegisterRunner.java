package karate.user;

import com.intuit.karate.junit5.Karate;


import static karate.infrastructure.utils.ConstantsFeatures.REGISTER;


public class RegisterRunner {


    @Karate.Test
    Karate queryTermsFindByChannel() {
        return Karate.run(REGISTER).relativeTo(getClass());
    }
}
