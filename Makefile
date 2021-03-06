# Created by: Wen Heping <wenheping@gmail.com>
# $FreeBSD: head/science/py-obspy/Makefile 499638 2019-04-22 13:16:33Z gerald $

PORTNAME=	obspy
PORTVERSION=	1.1.1
PORTREVISION=	2
CATEGORIES=	science python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	wen@FreeBSD.org
COMMENT=	Python framework for seismological observatories

LICENSE=	LGPL3

BUILD_DEPENDS=	${PYNUMPY} \
		${PYTHON_PKGNAMEPREFIX}scipy>=0.9.0:science/py-scipy@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}future>=0.12.4:devel/py-future@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}matplotlib>=1.1.0:math/py-matplotlib@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}lxml>=2.2:devel/py-lxml@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests>=0:www/py-requests@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}decorator>=0:devel/py-decorator@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}sqlalchemy10>=0:databases/py-sqlalchemy10@${PY_FLAVOR}

.if ${FLAVOR:Upy36:Mpy3*}
BUILD_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}suds-py3>=1.3.0:net/py-suds-py3@${PY_FLAVOR}
.else
BUILD_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}suds>=0.4.0:net/py-suds@${PY_FLAVOR}
.endif

RUN_DEPENDS:=	${BUILD_DEPENDS}

USES=		fortran python shebangfix zip
SHEBANG_FILES=	obspy/taup/tests/data/TauP_test_data/gendata.sh
USE_LDCONFIG=	yes
LDFLAGS+=	-shared
USE_PYTHON=	autoplist distutils

LDFLAGS+=	-shared

post-patch:
	${REINPLACE_CMD} -e "s#FC#${FC}#g" ${WRKSRC}/setup.py

post-install:
	@${STRIP_CMD} ${STAGEDIR}${PYTHONPREFIX_SITELIBDIR}/obspy/lib/*.so

.include <bsd.port.mk>
