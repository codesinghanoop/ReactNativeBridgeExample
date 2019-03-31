package com.example.counter;

import com.facebook.react.ReactApplication;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.uimanager.annotations.ReactProp;

        import javax.annotation.Nonnull;

public class CounterManager extends ReactContextBaseJavaModule {
    private int counting = 0;
    public CounterManager(ReactApplicationContext context) {
        super(context);
    }

    @ReactMethod
    public void reset(int value) {
        counting = value;
    }

    @ReactMethod
    public void incrementCounter() {
        counting = counting + 1;
    }

    @ReactMethod
    public void decreaseCounter() {
        counting = counting - 1;
    }

    @ReactMethod
    public void getStatus(Callback successCallback) {
        successCallback.invoke(null, counting);
    }

    @Override
    public String getName() {
        return "Counter";
    }
}

