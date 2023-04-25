FROM eclipse-temurin:19-jdk as build
WORKDIR /workspace/app

COPY . .
RUN ./gradlew clean bootJar -x test
RUN mv build/libs/$(./gradlew printVersion | grep "version:" | awk '{print $2}').jar ./build/libs/app.jar

FROM eclipse-temurin:19-jdk
WORKDIR /app
COPY --from=build /workspace/app/build/libs/app.jar /app
ENV TZ="America/SA"
ENTRYPOINT ["java","-jar","app.jar"]
