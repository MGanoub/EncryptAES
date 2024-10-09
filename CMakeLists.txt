cmake_minimum_required(VERSION 3.16)

project(testAES VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)


find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(apptestAES
    main.cpp
)

qt_add_qml_module(apptestAES
    URI testAES
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES cipher.h cipher.cpp
        SOURCES fileData.h fileData.cpp
        SOURCES application.h application.cpp
        QML_FILES CustomTextField.qml
        QML_FILES CustomButton.qml
        RESOURCES resource.qrc
)


set(OPENSSL_ROOT_DIR "C:/openssl-3.2.0/build")
set(OPENSSL_USE_STATIC_LIBS TRUE)
include(FindOpenSSL)
message(WARNING "FindSSL found: ${OPENSSL_FOUND}")
message(WARNING "FindSSL include dir: ${OPENSSL_INCLUDE_DIR}")
message(WARNING "FindSSL crypto lib: ${OPENSSL_CRYPTO_LIBRARY}")
message(WARNING "FindSSL Crypto dependencies: ${OPENSSL_CRYPTO_LIBRARIES}")
message(WARNING "FindSSL SSL lib: ${OPENSSL_SSL_LIBRARY}")
message(WARNING "FindSSL SSL dependencies: ${OPENSSL_SSL_LIBRARIES}")
message(WARNING "FindSSL ALL : ${OPENSSL_LIBRARIES}")

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apptestAES PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apptestAES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apptestAES
    PRIVATE Qt6::Quick OpenSSL::Crypto
)

include(GNUInstallDirs)
install(TARGETS apptestAES
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
