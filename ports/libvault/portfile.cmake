vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO abedra/libvault
    REF 0.44.0
    SHA512 125f0905cd9910a192a62b25010e67a91afb5d47039d4a4e821e37aebe610861d5e1349ea06311eb01df2f002a0f99b9e08e2a0833208ab941561e1acbbc262c
    HEAD_REF master
    PATCHES
        0001_fix_CMakeLists.txt.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DENABLE_TEST=OFF
)

vcpkg_build_cmake()

vcpkg_install_cmake()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/libvault")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
