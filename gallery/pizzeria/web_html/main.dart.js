(function dartProgram(){function copyProperties(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
b[q]=a[q]}}function mixinPropertiesHard(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
if(!b.hasOwnProperty(q)){b[q]=a[q]}}}function mixinPropertiesEasy(a,b){Object.assign(b,a)}var z=function(){var s=function(){}
s.prototype={p:{}}
var r=new s()
if(!(Object.getPrototypeOf(r)&&Object.getPrototypeOf(r).p===s.prototype.p))return false
try{if(typeof navigator!="undefined"&&typeof navigator.userAgent=="string"&&navigator.userAgent.indexOf("Chrome/")>=0)return true
if(typeof version=="function"&&version.length==0){var q=version()
if(/^\d+\.\d+\.\d+\.\d+$/.test(q))return true}}catch(p){}return false}()
function inherit(a,b){a.prototype.constructor=a
a.prototype["$i"+a.name]=a
if(b!=null){if(z){Object.setPrototypeOf(a.prototype,b.prototype)
return}var s=Object.create(b.prototype)
copyProperties(a.prototype,s)
a.prototype=s}}function inheritMany(a,b){for(var s=0;s<b.length;s++){inherit(b[s],a)}}function mixinEasy(a,b){mixinPropertiesEasy(b.prototype,a.prototype)
a.prototype.constructor=a}function mixinHard(a,b){mixinPropertiesHard(b.prototype,a.prototype)
a.prototype.constructor=a}function lazy(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){a[b]=d()}a[c]=function(){return this[b]}
return a[b]}}function lazyFinal(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){var r=d()
if(a[b]!==s){A.ma(b)}a[b]=r}var q=a[b]
a[c]=function(){return q}
return q}}function makeConstList(a,b){if(b!=null)A.d(a,b)
a.$flags=7
return a}function convertToFastObject(a){function t(){}t.prototype=a
new t()
return a}function convertAllToFastObject(a){for(var s=0;s<a.length;++s){convertToFastObject(a[s])}}var y=0
function instanceTearOffGetter(a,b){var s=null
return a?function(c){if(s===null)s=A.hy(b)
return new s(c,this)}:function(){if(s===null)s=A.hy(b)
return new s(this,null)}}function staticTearOffGetter(a){var s=null
return function(){if(s===null)s=A.hy(a).prototype
return s}}var x=0
function tearOffParameters(a,b,c,d,e,f,g,h,i,j){if(typeof h=="number"){h+=x}return{co:a,iS:b,iI:c,rC:d,dV:e,cs:f,fs:g,fT:h,aI:i||0,nDA:j}}function installStaticTearOff(a,b,c,d,e,f,g,h){var s=tearOffParameters(a,true,false,c,d,e,f,g,h,false)
var r=staticTearOffGetter(s)
a[b]=r}function installInstanceTearOff(a,b,c,d,e,f,g,h,i,j){c=!!c
var s=tearOffParameters(a,false,c,d,e,f,g,h,i,!!j)
var r=instanceTearOffGetter(c,s)
a[b]=r}function setOrUpdateInterceptorsByTag(a){var s=v.interceptorsByTag
if(!s){v.interceptorsByTag=a
return}copyProperties(a,s)}function setOrUpdateLeafTags(a){var s=v.leafTags
if(!s){v.leafTags=a
return}copyProperties(a,s)}function updateTypes(a){var s=v.types
var r=s.length
s.push.apply(s,a)
return r}function updateHolder(a,b){copyProperties(b,a)
return a}var hunkHelpers=function(){var s=function(a,b,c,d,e){return function(f,g,h,i){return installInstanceTearOff(f,g,a,b,c,d,[h],i,e,false)}},r=function(a,b,c,d){return function(e,f,g,h){return installStaticTearOff(e,f,a,b,c,[g],h,d)}}
return{inherit:inherit,inheritMany:inheritMany,mixin:mixinEasy,mixinHard:mixinHard,installStaticTearOff:installStaticTearOff,installInstanceTearOff:installInstanceTearOff,_instance_0u:s(0,0,null,["$0"],0),_instance_1u:s(0,1,null,["$1"],0),_instance_2u:s(0,2,null,["$2"],0),_instance_0i:s(1,0,null,["$0"],0),_instance_1i:s(1,1,null,["$1"],0),_instance_2i:s(1,2,null,["$2"],0),_static_0:r(0,null,["$0"],0),_static_1:r(1,null,["$1"],0),_static_2:r(2,null,["$2"],0),makeConstList:makeConstList,lazy:lazy,lazyFinal:lazyFinal,updateHolder:updateHolder,convertToFastObject:convertToFastObject,updateTypes:updateTypes,setOrUpdateInterceptorsByTag:setOrUpdateInterceptorsByTag,setOrUpdateLeafTags:setOrUpdateLeafTags}}()
function initializeDeferredHunk(a){x=v.types.length
a(hunkHelpers,v,w,$)}var J={
hD(a,b,c,d){return{i:a,p:b,e:c,x:d}},
fV(a){var s,r,q,p,o,n="_$dart_js",m=a[v.dispatchPropertyName]
if(m==null)if($.hB==null){A.lZ()
m=a[v.dispatchPropertyName]}if(m!=null){s=m.p
if(!1===s)return m.i
if(!0===s)return a
r=Object.getPrototypeOf(a)
if(s===r)return m.i
if(m.e===r)throw A.e(A.ih("Return interceptor for "+A.n(s(a,m))))}q=a.constructor
if(q==null)p=null
else{o=$.ft
if(o==null)o=$.ft=A.fU(n)
p=q[o]}if(p!=null)return p
p=A.m2(a)
if(p!=null)return p
if(typeof a=="function")return B.P
s=Object.getPrototypeOf(a)
if(s==null)return B.x
if(s===Object.prototype)return B.x
if(typeof q=="function"){o=$.ft
if(o==null)o=$.ft=A.fU(n)
Object.defineProperty(q,o,{value:B.o,enumerable:false,writable:true,configurable:true})
return B.o}return B.o},
hW(a,b){if(a<0||a>4294967295)throw A.e(A.ax(a,0,4294967295,"length",null))
return J.jO(new Array(a),b)},
jO(a,b){var s=A.d(a,b.h("p<0>"))
s.$flags=1
return s},
jP(a,b){var s=t.r
return J.js(s.a(a),s.a(b))},
bl(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.c8.prototype
return J.db.prototype}if(typeof a=="string")return J.b3.prototype
if(a==null)return J.c9.prototype
if(typeof a=="boolean")return J.c7.prototype
if(Array.isArray(a))return J.p.prototype
if(typeof a!="object"){if(typeof a=="function")return J.at.prototype
if(typeof a=="symbol")return J.bu.prototype
if(typeof a=="bigint")return J.bt.prototype
return a}if(a instanceof A.w)return a
return J.fV(a)},
ek(a){if(typeof a=="string")return J.b3.prototype
if(a==null)return a
if(Array.isArray(a))return J.p.prototype
if(typeof a!="object"){if(typeof a=="function")return J.at.prototype
if(typeof a=="symbol")return J.bu.prototype
if(typeof a=="bigint")return J.bt.prototype
return a}if(a instanceof A.w)return a
return J.fV(a)},
hz(a){if(a==null)return a
if(Array.isArray(a))return J.p.prototype
if(typeof a!="object"){if(typeof a=="function")return J.at.prototype
if(typeof a=="symbol")return J.bu.prototype
if(typeof a=="bigint")return J.bt.prototype
return a}if(a instanceof A.w)return a
return J.fV(a)},
lV(a){if(typeof a=="number")return J.bs.prototype
if(typeof a=="string")return J.b3.prototype
if(a==null)return a
if(!(a instanceof A.w))return J.bB.prototype
return a},
lW(a){if(a==null)return a
if(typeof a!="object"){if(typeof a=="function")return J.at.prototype
if(typeof a=="symbol")return J.bu.prototype
if(typeof a=="bigint")return J.bt.prototype
return a}if(a instanceof A.w)return a
return J.fV(a)},
al(a,b){if(a==null)return b==null
if(typeof a!="object")return b!=null&&a===b
return J.bl(a).F(a,b)},
jr(a,b,c){return J.lW(a).cE(a,b,c)},
js(a,b){return J.lV(a).K(a,b)},
hN(a,b){return J.hz(a).L(a,b)},
af(a){return J.bl(a).gp(a)},
h5(a){return J.hz(a).gC(a)},
c0(a){return J.ek(a).gl(a)},
jt(a){return J.bl(a).gB(a)},
ju(a,b){return J.hz(a).aW(a,b)},
cZ(a){return J.bl(a).i(a)},
d9:function d9(){},
c7:function c7(){},
c9:function c9(){},
ca:function ca(){},
aO:function aO(){},
dr:function dr(){},
bB:function bB(){},
at:function at(){},
bt:function bt(){},
bu:function bu(){},
p:function p(a){this.$ti=a},
da:function da(){},
er:function er(a){this.$ti=a},
c1:function c1(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
bs:function bs(){},
c8:function c8(){},
db:function db(){},
b3:function b3(){}},A={h9:function h9(){},
hY(a){return new A.bv("Field '"+a+"' has not been initialized.")},
jQ(a){return new A.bv("Field '"+a+"' has already been initialized.")},
ay(a,b){a=a+b&536870911
a=a+((a&524287)<<10)&536870911
return a^a>>>6},
eM(a){a=a+((a&67108863)<<3)&536870911
a^=a>>>11
return a+((a&16383)<<15)&536870911},
hx(a,b,c){return a},
hC(a){var s,r
for(s=$.a5.length,r=0;r<s;++r)if(a===$.a5[r])return!0
return!1},
ic(a,b,c,d){A.cm(b,"start")
return new A.cs(a,b,c,d.h("cs<0>"))},
k1(a,b,c){var s="count"
if(t.G.b(a)){A.hO(b,s,t.S)
A.cm(b,s)
return new A.c4(a,b,c.h("c4<0>"))}A.hO(b,s,t.S)
A.cm(b,s)
return new A.b6(a,b,c.h("b6<0>"))},
hV(){return new A.bA("No element")},
jL(){return new A.bA("Too few elements")},
bv:function bv(a){this.a=a},
c2:function c2(a){this.a=a},
eK:function eK(){},
k:function k(){},
ao:function ao(){},
cs:function cs(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.$ti=d},
av:function av(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
aw:function aw(a,b,c){this.a=a
this.b=b
this.$ti=c},
aB:function aB(a,b,c){this.a=a
this.b=b
this.$ti=c},
cv:function cv(a,b,c){this.a=a
this.b=b
this.$ti=c},
b6:function b6(a,b,c){this.a=a
this.b=b
this.$ti=c},
c4:function c4(a,b,c){this.a=a
this.b=b
this.$ti=c},
cp:function cp(a,b,c){this.a=a
this.b=b
this.$ti=c},
V:function V(){},
b7:function b7(){},
bC:function bC(){},
ja(a){var s=A.j9(a)
if(s!=null)return s
return"minified:"+a},
mH(a,b){var s
if(b!=null){s=b.x
if(s!=null)return s}return t.aU.b(a)},
n(a){var s
if(typeof a=="string")return a
if(typeof a=="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
s=J.cZ(a)
return s},
ck(a){var s,r=$.i0
if(r==null)r=$.i0=Symbol("identityHashCode")
s=a[r]
if(s==null){s=Math.random()*0x3fffffff|0
a[r]=s}return s},
jZ(a,b){var s,r=/^\s*[+-]?((0x[a-f0-9]+)|(\d+)|([a-z0-9]+))\s*$/i.exec(a)
if(r==null)return null
if(3>=r.length)return A.l(r,3)
s=r[3]
if(s!=null)return parseInt(a,10)
if(r[2]!=null)return parseInt(a,16)
return null},
ds(a){var s,r,q,p
if(a instanceof A.w)return A.a4(A.bm(a),null)
s=J.bl(a)
if(s===B.O||s===B.Q||t.ak.b(a)){r=B.r(a)
if(r!=="Object"&&r!=="")return r
q=a.constructor
if(typeof q=="function"){p=q.name
if(typeof p=="string"&&p!=="Object"&&p!=="")return p}}return A.a4(A.bm(a),null)},
i7(a){var s,r,q
if(a==null||typeof a=="number"||A.ht(a))return J.cZ(a)
if(typeof a=="string")return JSON.stringify(a)
if(a instanceof A.aL)return a.i(0)
if(a instanceof A.aa)return a.cw(!0)
s=$.jm()
for(r=0;r<1;++r){q=s[r].eS(a)
if(q!=null)return q}return"Instance of '"+A.ds(a)+"'"},
jV(){return Date.now()},
jY(){var s,r
if($.eC!==0)return
$.eC=1000
if(typeof window=="undefined")return
s=window
if(s==null)return
if(!!s.dartUseDateNowForTicks)return
r=s.performance
if(r==null)return
if(typeof r.now!="function")return
$.eC=1e6
$.dt=new A.eB(r)},
O(a){var s
if(0<=a){if(a<=65535)return String.fromCharCode(a)
if(a<=1114111){s=a-65536
return String.fromCharCode((B.c.ct(s,10)|55296)>>>0,s&1023|56320)}}throw A.e(A.ax(a,0,1114111,null,null))},
a3(a){if(a.date===void 0)a.date=new Date(a.a)
return a.date},
i6(a){return a.c?A.a3(a).getUTCFullYear()+0:A.a3(a).getFullYear()+0},
i4(a){return a.c?A.a3(a).getUTCMonth()+1:A.a3(a).getMonth()+1},
i1(a){return a.c?A.a3(a).getUTCDate()+0:A.a3(a).getDate()+0},
i2(a){return a.c?A.a3(a).getUTCHours()+0:A.a3(a).getHours()+0},
i3(a){return a.c?A.a3(a).getUTCMinutes()+0:A.a3(a).getMinutes()+0},
i5(a){return a.c?A.a3(a).getUTCSeconds()+0:A.a3(a).getSeconds()+0},
jX(a){return a.c?A.a3(a).getUTCMilliseconds()+0:A.a3(a).getMilliseconds()+0},
jW(a){var s=a.$thrownJsError
if(s==null)return null
return A.aZ(s)},
i8(a,b){var s
if(a.$thrownJsError==null){s=new Error()
A.I(a,s)
a.$thrownJsError=s
s.stack=b.i(0)}},
hA(a){throw A.e(A.j0(a))},
l(a,b){if(a==null)J.c0(a)
throw A.e(A.fS(a,b))},
fS(a,b){var s,r="index"
if(!A.iN(b))return new A.am(!0,b,r,null)
s=J.c0(a)
if(b<0||b>=s)return A.h7(b,s,a,r)
return A.i9(b,r)},
j0(a){return new A.am(!0,a,null,null)},
e(a){return A.I(a,new Error())},
I(a,b){var s
if(a==null)a=new A.az()
b.dartException=a
s=A.mb
if("defineProperty" in Object){Object.defineProperty(b,"message",{get:s})
b.name=""}else b.toString=s
return b},
mb(){return J.cZ(this.dartException)},
h2(a,b){throw A.I(a,b==null?new Error():b)},
aj(a,b,c){var s
if(b==null)b=0
if(c==null)c=0
s=Error()
A.h2(A.kP(a,b,c),s)},
kP(a,b,c){var s,r,q,p,o,n,m,l,k
if(typeof b=="string")s=b
else{r="[]=;add;removeWhere;retainWhere;removeRange;setRange;setInt8;setInt16;setInt32;setUint8;setUint16;setUint32;setFloat32;setFloat64".split(";")
q=r.length
p=b
if(p>q){c=p/q|0
p%=q}s=r[p]}o=typeof c=="string"?c:"modify;remove from;add to".split(";")[c]
n=t.j.b(a)?"list":"ByteData"
m=a.$flags|0
l="a "
if((m&4)!==0)k="constant "
else if((m&2)!==0){k="unmodifiable "
l="an "}else k=(m&1)!==0?"fixed-length ":""
return new A.cu("'"+s+"': Cannot "+o+" "+l+k+n)},
u(a){throw A.e(A.a7(a))},
aA(a){var s,r,q,p,o,n
a=A.j7(a.replace(String({}),"$receiver$"))
s=a.match(/\\\$[a-zA-Z]+\\\$/g)
if(s==null)s=A.d([],t.s)
r=s.indexOf("\\$arguments\\$")
q=s.indexOf("\\$argumentsExpr\\$")
p=s.indexOf("\\$expr\\$")
o=s.indexOf("\\$method\\$")
n=s.indexOf("\\$receiver\\$")
return new A.eN(a.replace(new RegExp("\\\\\\$arguments\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$argumentsExpr\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$expr\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$method\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$receiver\\\\\\$","g"),"((?:x|[^x])*)"),r,q,p,o,n)},
eO(a){return function($expr$){var $argumentsExpr$="$arguments$"
try{$expr$.$method$($argumentsExpr$)}catch(s){return s.message}}(a)},
ig(a){return function($expr$){try{$expr$.$method$}catch(s){return s.message}}(a)},
ha(a,b){var s=b==null,r=s?null:b.method
return new A.dc(a,r,s?null:b.receiver)},
b0(a){var s
if(a==null)return new A.eA(a)
if(a instanceof A.c5){s=a.a
return A.b_(a,s==null?A.bL(s):s)}if(typeof a!=="object")return a
if("dartException" in a)return A.b_(a,a.dartException)
return A.lI(a)},
b_(a,b){if(t.C.b(b))if(b.$thrownJsError==null)b.$thrownJsError=a
return b},
lI(a){var s,r,q,p,o,n,m,l,k,j,i,h,g
if(!("message" in a))return a
s=a.message
if("number" in a&&typeof a.number=="number"){r=a.number
q=r&65535
if((B.c.ct(r,16)&8191)===10)switch(q){case 438:return A.b_(a,A.ha(A.n(s)+" (Error "+q+")",null))
case 445:case 5007:A.n(s)
return A.b_(a,new A.cj())}}if(a instanceof TypeError){p=$.jc()
o=$.jd()
n=$.je()
m=$.jf()
l=$.ji()
k=$.jj()
j=$.jh()
$.jg()
i=$.jl()
h=$.jk()
g=p.R(s)
if(g!=null)return A.b_(a,A.ha(A.H(s),g))
else{g=o.R(s)
if(g!=null){g.method="call"
return A.b_(a,A.ha(A.H(s),g))}else if(n.R(s)!=null||m.R(s)!=null||l.R(s)!=null||k.R(s)!=null||j.R(s)!=null||m.R(s)!=null||i.R(s)!=null||h.R(s)!=null){A.H(s)
return A.b_(a,new A.cj())}}return A.b_(a,new A.dD(typeof s=="string"?s:""))}if(a instanceof RangeError){if(typeof s=="string"&&s.indexOf("call stack")!==-1)return new A.cq()
s=function(b){try{return String(b)}catch(f){}return null}(a)
return A.b_(a,new A.am(!1,null,null,typeof s=="string"?s.replace(/^RangeError:\s*/,""):s))}if(typeof InternalError=="function"&&a instanceof InternalError)if(typeof s=="string"&&s==="too much recursion")return new A.cq()
return a},
aZ(a){var s
if(a instanceof A.c5)return a.b
if(a==null)return new A.cN(a)
s=a.$cachedTrace
if(s!=null)return s
s=new A.cN(a)
if(typeof a==="object")a.$cachedTrace=s
return s},
hE(a){if(a==null)return J.af(a)
if(typeof a=="object")return A.ck(a)
return J.af(a)},
lP(a){if(typeof a=="number")return B.b.gp(a)
if(a instanceof A.eg)return A.ck(a)
if(a instanceof A.aa)return a.gp(a)
return A.hE(a)},
j3(a,b){var s,r,q,p=a.length
for(s=0;s<p;s=q){r=s+1
q=r+1
b.n(0,a[s],a[r])}return b},
lh(a,b,c,d,e,f){t.Z.a(a)
switch(A.c(b)){case 0:return a.$0()
case 1:return a.$1(c)
case 2:return a.$2(c,d)
case 3:return a.$3(c,d,e)
case 4:return a.$4(c,d,e,f)}throw A.e(new A.fg("Unsupported number of arguments for wrapped closure"))},
bj(a,b){var s=a.$identity
if(!!s)return s
s=A.lQ(a,b)
a.$identity=s
return s},
lQ(a,b){var s
switch(b){case 0:s=a.$0
break
case 1:s=a.$1
break
case 2:s=a.$2
break
case 3:s=a.$3
break
case 4:s=a.$4
break
default:s=null}if(s!=null)return s.bind(a)
return function(c,d,e){return function(f,g,h,i){return e(c,d,f,g,h,i)}}(a,b,A.lh)},
jB(a2){var s,r,q,p,o,n,m,l,k,j,i=a2.co,h=a2.iS,g=a2.iI,f=a2.nDA,e=a2.aI,d=a2.fs,c=a2.cs,b=d[0],a=c[0],a0=i[b],a1=a2.fT
a1.toString
s=h?Object.create(new A.dz().constructor.prototype):Object.create(new A.bq(null,null).constructor.prototype)
s.$initialize=s.constructor
r=h?function static_tear_off(){this.$initialize()}:function tear_off(a3,a4){this.$initialize(a3,a4)}
s.constructor=r
r.prototype=s
s.$_name=b
s.$_target=a0
q=!h
if(q)p=A.hT(b,a0,g,f)
else{s.$static_name=b
p=a0}s.$S=A.jx(a1,h,g)
s[a]=p
for(o=p,n=1;n<d.length;++n){m=d[n]
if(typeof m=="string"){l=i[m]
k=m
m=l}else k=""
j=c[n]
if(j!=null){if(q)m=A.hT(k,m,g,f)
s[j]=m}if(n===e)o=m}s.$C=o
s.$R=a2.rC
s.$D=a2.dV
return r},
jx(a,b,c){if(typeof a=="number")return a
if(typeof a=="string"){if(b)throw A.e("Cannot compute signature for static tearoff.")
return function(d,e){return function(){return e(this,d)}}(a,A.jv)}throw A.e("Error in functionType of tearoff")},
jy(a,b,c,d){var s=A.hS
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,s)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,s)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,s)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,s)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,s)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,s)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,s)}},
hT(a,b,c,d){if(c)return A.jA(a,b,d)
return A.jy(b.length,d,a,b)},
jz(a,b,c,d){var s=A.hS,r=A.jw
switch(b?-1:a){case 0:throw A.e(new A.dx("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,r,s)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,r,s)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,r,s)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,r,s)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,r,s)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,r,s)
default:return function(e,f,g){return function(){var q=[g(this)]
Array.prototype.push.apply(q,arguments)
return e.apply(f(this),q)}}(d,r,s)}},
jA(a,b,c){var s,r
if($.hQ==null)$.hQ=A.hP("interceptor")
if($.hR==null)$.hR=A.hP("receiver")
s=b.length
r=A.jz(s,c,a,b)
return r},
hy(a){return A.jB(a)},
jv(a,b){return A.cT(v.typeUniverse,A.bm(a.a),b)},
hS(a){return a.a},
jw(a){return a.b},
hP(a){var s,r,q,p=new A.bq("receiver","interceptor"),o=Object.getOwnPropertyNames(p)
o.$flags=1
s=o
for(o=s.length,r=0;r<o;++r){q=s[r]
if(p[q]===a)return q}throw A.e(A.en("Field name "+a+" not found.",null))},
fU(a){return v.getIsolateTag(a)},
m7(){return v.G},
mD(a,b,c){Object.defineProperty(a,b,{value:c,enumerable:false,writable:true,configurable:true})},
m2(a){var s,r,q,p,o,n=A.H($.j4.$1(a)),m=$.fT[n]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.fZ[n]
if(s!=null)return s
r=v.interceptorsByTag[n]
if(r==null){q=A.iI($.j_.$2(a,n))
if(q!=null){m=$.fT[q]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.fZ[q]
if(s!=null)return s
r=v.interceptorsByTag[q]
n=q}}if(r==null)return null
s=r.prototype
p=n[0]
if(p==="!"){m=A.h_(s)
$.fT[n]=m
Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}if(p==="~"){$.fZ[n]=s
return s}if(p==="-"){o=A.h_(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}if(p==="+")return A.j5(a,s)
if(p==="*")throw A.e(A.ih(n))
if(v.leafTags[n]===true){o=A.h_(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}else return A.j5(a,s)},
j5(a,b){var s=Object.getPrototypeOf(a)
Object.defineProperty(s,v.dispatchPropertyName,{value:J.hD(b,s,null,null),enumerable:false,writable:true,configurable:true})
return b},
h_(a){return J.hD(a,!1,null,!!a.$ia0)},
m4(a,b,c){var s=b.prototype
if(v.leafTags[a]===true)return A.h_(s)
else return J.hD(s,c,null,null)},
lZ(){if(!0===$.hB)return
$.hB=!0
A.m_()},
m_(){var s,r,q,p,o,n,m,l
$.fT=Object.create(null)
$.fZ=Object.create(null)
A.lY()
s=v.interceptorsByTag
r=Object.getOwnPropertyNames(s)
if(typeof window!="undefined"){window
q=function(){}
for(p=0;p<r.length;++p){o=r[p]
n=$.j6.$1(o)
if(n!=null){m=A.m4(o,s[o],n)
if(m!=null){Object.defineProperty(n,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
q.prototype=n}}}}for(p=0;p<r.length;++p){o=r[p]
if(/^[A-Za-z_]/.test(o)){l=s[o]
s["!"+o]=l
s["~"+o]=l
s["-"+o]=l
s["+"+o]=l
s["*"+o]=l}}},
lY(){var s,r,q,p,o,n,m=B.E()
m=A.bV(B.F,A.bV(B.G,A.bV(B.t,A.bV(B.t,A.bV(B.H,A.bV(B.I,A.bV(B.J(B.r),m)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){s=dartNativeDispatchHooksTransformer
if(typeof s=="function")s=[s]
if(Array.isArray(s))for(r=0;r<s.length;++r){q=s[r]
if(typeof q=="function")m=q(m)||m}}p=m.getTag
o=m.getUnknownTag
n=m.prototypeForTag
$.j4=new A.fW(p)
$.j_=new A.fX(o)
$.j6=new A.fY(n)},
bV(a,b){return a(b)||b},
ks(a,b){var s,r
for(s=0;s<a.length;++s){r=a[s]
if(!(s<b.length))return A.l(b,s)
if(!J.al(r,b[s]))return!1}return!0},
lS(a,b){var s=b.length,r=v.rttc[""+s+";"+a]
if(r==null)return null
if(s===0)return r
if(s===r.length)return r.apply(null,b)
return r(b)},
lT(a){if(a.indexOf("$",0)>=0)return a.replace(/\$/g,"$$$$")
return a},
j7(a){if(/[[\]{}()*+?.\\^$|]/.test(a))return a.replace(/[[\]{}()*+?.\\^$|]/g,"\\$&")
return a},
m8(a,b,c){var s=A.m9(a,b,c)
return s},
m9(a,b,c){var s,r,q
if(b===""){if(a==="")return c
s=a.length
for(r=c,q=0;q<s;++q)r=r+a[q]+c
return r.charCodeAt(0)==0?r:r}if(a.indexOf(b,0)<0)return a
if(a.length<500||c.indexOf("$",0)>=0)return a.split(b).join(c)
return a.replace(new RegExp(A.j7(b),"g"),A.lT(c))},
cL:function cL(a,b){this.a=a
this.b=b},
bh:function bh(a,b,c){this.a=a
this.b=b
this.c=c},
aX:function aX(a){this.a=a},
br:function br(){},
c3:function c3(a,b,c){this.a=a
this.b=b
this.$ti=c},
c6:function c6(a,b){this.a=a
this.$ti=b},
eB:function eB(a){this.a=a},
co:function co(){},
eN:function eN(a,b,c,d,e,f){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f},
cj:function cj(){},
dc:function dc(a,b,c){this.a=a
this.b=b
this.c=c},
dD:function dD(a){this.a=a},
eA:function eA(a){this.a=a},
c5:function c5(a,b){this.a=a
this.b=b},
cN:function cN(a){this.a=a
this.b=null},
aL:function aL(){},
d1:function d1(){},
d2:function d2(){},
dA:function dA(){},
dz:function dz(){},
bq:function bq(a,b){this.a=a
this.b=b},
dx:function dx(a){this.a=a},
au:function au(a){var _=this
_.a=0
_.f=_.e=_.d=_.c=_.b=null
_.r=0
_.$ti=a},
eu:function eu(a,b){var _=this
_.a=a
_.b=b
_.d=_.c=null},
ev:function ev(a,b){this.a=a
this.$ti=b},
b4:function b4(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=null
_.$ti=d},
ce:function ce(a,b){this.a=a
this.$ti=b},
cd:function cd(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=null
_.$ti=d},
cb:function cb(a){var _=this
_.a=0
_.f=_.e=_.d=_.c=_.b=null
_.r=0
_.$ti=a},
fW:function fW(a){this.a=a},
fX:function fX(a){this.a=a},
fY:function fY(a){this.a=a},
aa:function aa(){},
bH:function bH(){},
bI:function bI(){},
bJ:function bJ(){},
ma(a){throw A.I(new A.bv("Field '"+a+"' has been assigned during initialization."),new Error())},
b(){throw A.I(A.hY(""),new Error())},
j8(){throw A.I(A.jQ(""),new Error())},
kh(){var s=new A.fe()
return s.b=s},
fe:function fe(){this.b=null},
jT(a,b,c){var s=new Uint8Array(a,b,c)
return s},
aH(a,b,c){if(a>>>0!==a||a>=c)throw A.e(A.fS(b,a))},
b5:function b5(){},
cg:function cg(){},
fE:function fE(a){this.a=a},
dg:function dg(){},
T:function T(){},
cf:function cf(){},
a2:function a2(){},
dh:function dh(){},
di:function di(){},
dj:function dj(){},
dk:function dk(){},
dl:function dl(){},
dm:function dm(){},
dn:function dn(){},
ch:function ch(){},
ci:function ci(){},
cH:function cH(){},
cI:function cI(){},
cJ:function cJ(){},
cK:function cK(){},
hf(a,b){var s=b.c
return s==null?b.c=A.cR(a,"an",[b.x]):s},
ia(a){var s=a.w
if(s===6||s===7)return A.ia(a.x)
return s===11||s===12},
k0(a){return a.as},
m5(a,b){var s,r=b.length
for(s=0;s<r;++s)if(!a[s].b(b[s]))return!1
return!0},
as(a){return A.fD(v.typeUniverse,a,!1)},
bi(a1,a2,a3,a4){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0=a2.w
switch(a0){case 5:case 1:case 2:case 3:case 4:return a2
case 6:s=a2.x
r=A.bi(a1,s,a3,a4)
if(r===s)return a2
return A.iB(a1,r,!0)
case 7:s=a2.x
r=A.bi(a1,s,a3,a4)
if(r===s)return a2
return A.iA(a1,r,!0)
case 8:q=a2.y
p=A.bS(a1,q,a3,a4)
if(p===q)return a2
return A.cR(a1,a2.x,p)
case 9:o=a2.x
n=A.bi(a1,o,a3,a4)
m=a2.y
l=A.bS(a1,m,a3,a4)
if(n===o&&l===m)return a2
return A.hk(a1,n,l)
case 10:k=a2.x
j=a2.y
i=A.bS(a1,j,a3,a4)
if(i===j)return a2
return A.iC(a1,k,i)
case 11:h=a2.x
g=A.bi(a1,h,a3,a4)
f=a2.y
e=A.lE(a1,f,a3,a4)
if(g===h&&e===f)return a2
return A.iz(a1,g,e)
case 12:d=a2.y
a4+=d.length
c=A.bS(a1,d,a3,a4)
o=a2.x
n=A.bi(a1,o,a3,a4)
if(c===d&&n===o)return a2
return A.hl(a1,n,c,!0)
case 13:b=a2.x
if(b<a4)return a2
a=a3[b-a4]
if(a==null)return a2
return a
default:throw A.e(A.d0("Attempted to substitute unexpected RTI kind "+a0))}},
bS(a,b,c,d){var s,r,q,p,o=b.length,n=A.fF(o)
for(s=!1,r=0;r<o;++r){q=b[r]
p=A.bi(a,q,c,d)
if(p!==q)s=!0
n[r]=p}return s?n:b},
lF(a,b,c,d){var s,r,q,p,o,n,m=b.length,l=A.fF(m)
for(s=!1,r=0;r<m;r+=3){q=b[r]
p=b[r+1]
o=b[r+2]
n=A.bi(a,o,c,d)
if(n!==o)s=!0
l.splice(r,3,q,p,n)}return s?l:b},
lE(a,b,c,d){var s,r=b.a,q=A.bS(a,r,c,d),p=b.b,o=A.bS(a,p,c,d),n=b.c,m=A.lF(a,n,c,d)
if(q===r&&o===p&&m===n)return b
s=new A.ea()
s.a=q
s.b=o
s.c=m
return s},
d(a,b){a[v.arrayRti]=b
return a},
j2(a){var s=a.$S
if(s!=null){if(typeof s=="number")return A.lX(s)
return a.$S()}return null},
m0(a,b){var s
if(A.ia(b))if(a instanceof A.aL){s=A.j2(a)
if(s!=null)return s}return A.bm(a)},
bm(a){if(a instanceof A.w)return A.ae(a)
if(Array.isArray(a))return A.R(a)
return A.hs(J.bl(a))},
R(a){var s=a[v.arrayRti],r=t.gn
if(s==null)return r
if(s.constructor!==r.constructor)return r
return s},
ae(a){var s=a.$ti
return s!=null?s:A.hs(a)},
hs(a){var s=a.constructor,r=s.$ccache
if(r!=null)return r
return A.ld(a,s)},
ld(a,b){var s=a instanceof A.aL?Object.getPrototypeOf(Object.getPrototypeOf(a)).constructor:b,r=A.kC(v.typeUniverse,s.name)
b.$ccache=r
return r},
lX(a){var s,r=v.types,q=r[a]
if(typeof q=="string"){s=A.fD(v.typeUniverse,q,!1)
r[a]=s
return s}return q},
bW(a){return A.bk(A.ae(a))},
hw(a){var s
if(a instanceof A.aa)return A.lU(a.$r,a.aA())
s=a instanceof A.aL?A.j2(a):null
if(s!=null)return s
if(t.dm.b(a))return J.jt(a).a
if(Array.isArray(a))return A.R(a)
return A.bm(a)},
bk(a){var s=a.r
return s==null?a.r=new A.eg(a):s},
lU(a,b){var s,r,q=b,p=q.length
if(p===0)return t.bQ
if(0>=p)return A.l(q,0)
s=A.cT(v.typeUniverse,A.hw(q[0]),"@<0>")
for(r=1;r<p;++r){if(!(r<q.length))return A.l(q,r)
s=A.iE(v.typeUniverse,s,A.hw(q[r]))}return A.cT(v.typeUniverse,s,a)},
ak(a){return A.bk(A.fD(v.typeUniverse,a,!1))},
lc(a){var s=this
s.b=A.lC(s)
return s.b(a)},
lC(a){var s,r,q,p,o
if(a===t.K)return A.ln
if(A.bn(a))return A.lr
s=a.w
if(s===6)return A.l8
if(s===1)return A.iP
if(s===7)return A.li
r=A.lB(a)
if(r!=null)return r
if(s===8){q=a.x
if(a.y.every(A.bn)){a.f="$i"+q
if(q==="m")return A.ll
if(a===t.m)return A.lk
return A.lq}}else if(s===10){p=A.lS(a.x,a.y)
o=p==null?A.iP:p
return o==null?A.bL(o):o}return A.l6},
lB(a){if(a.w===8){if(a===t.S)return A.iN
if(a===t.i||a===t.o)return A.lm
if(a===t.N)return A.lp
if(a===t.v)return A.ht}return null},
lb(a){var s=this,r=A.l5
if(A.bn(s))r=A.kH
else if(s===t.K)r=A.bL
else if(A.bX(s)){r=A.l7
if(s===t.h6)r=A.kG
else if(s===t.dk)r=A.iI
else if(s===t.fQ)r=A.kE
else if(s===t.cg)r=A.iH
else if(s===t.I)r=A.kF
else if(s===t.an)r=A.hn}else if(s===t.S)r=A.c
else if(s===t.N)r=A.H
else if(s===t.v)r=A.K
else if(s===t.o)r=A.ho
else if(s===t.i)r=A.ac
else if(s===t.m)r=A.U
s.a=r
return s.a(a)},
l6(a){var s=this
if(a==null)return A.bX(s)
return A.m1(v.typeUniverse,A.m0(a,s),s)},
l8(a){if(a==null)return!0
return this.x.b(a)},
lq(a){var s,r=this
if(a==null)return A.bX(r)
s=r.f
if(a instanceof A.w)return!!a[s]
return!!J.bl(a)[s]},
ll(a){var s,r=this
if(a==null)return A.bX(r)
if(typeof a!="object")return!1
if(Array.isArray(a))return!0
s=r.f
if(a instanceof A.w)return!!a[s]
return!!J.bl(a)[s]},
lk(a){var s=this
if(a==null)return!1
if(typeof a=="object"){if(a instanceof A.w)return!!a[s.f]
return!0}if(typeof a=="function")return!0
return!1},
iO(a){if(typeof a=="object"){if(a instanceof A.w)return t.m.b(a)
return!0}if(typeof a=="function")return!0
return!1},
l5(a){var s=this
if(a==null){if(A.bX(s))return a}else if(s.b(a))return a
throw A.I(A.iK(a,s),new Error())},
l7(a){var s=this
if(a==null||s.b(a))return a
throw A.I(A.iK(a,s),new Error())},
iK(a,b){return new A.cP("TypeError: "+A.it(a,A.a4(b,null)))},
it(a,b){return A.d7(a)+": type '"+A.a4(A.hw(a),null)+"' is not a subtype of type '"+b+"'"},
ab(a,b){return new A.cP("TypeError: "+A.it(a,b))},
li(a){var s=this
return s.x.b(a)||A.hf(v.typeUniverse,s).b(a)},
ln(a){return a!=null},
bL(a){if(a!=null)return a
throw A.I(A.ab(a,"Object"),new Error())},
lr(a){return!0},
kH(a){return a},
iP(a){return!1},
ht(a){return!0===a||!1===a},
K(a){if(!0===a)return!0
if(!1===a)return!1
throw A.I(A.ab(a,"bool"),new Error())},
kE(a){if(!0===a)return!0
if(!1===a)return!1
if(a==null)return a
throw A.I(A.ab(a,"bool?"),new Error())},
ac(a){if(typeof a=="number")return a
throw A.I(A.ab(a,"double"),new Error())},
kF(a){if(typeof a=="number")return a
if(a==null)return a
throw A.I(A.ab(a,"double?"),new Error())},
iN(a){return typeof a=="number"&&Math.floor(a)===a},
c(a){if(typeof a=="number"&&Math.floor(a)===a)return a
throw A.I(A.ab(a,"int"),new Error())},
kG(a){if(typeof a=="number"&&Math.floor(a)===a)return a
if(a==null)return a
throw A.I(A.ab(a,"int?"),new Error())},
lm(a){return typeof a=="number"},
ho(a){if(typeof a=="number")return a
throw A.I(A.ab(a,"num"),new Error())},
iH(a){if(typeof a=="number")return a
if(a==null)return a
throw A.I(A.ab(a,"num?"),new Error())},
lp(a){return typeof a=="string"},
H(a){if(typeof a=="string")return a
throw A.I(A.ab(a,"String"),new Error())},
iI(a){if(typeof a=="string")return a
if(a==null)return a
throw A.I(A.ab(a,"String?"),new Error())},
U(a){if(A.iO(a))return a
throw A.I(A.ab(a,"JSObject"),new Error())},
hn(a){if(a==null)return a
if(A.iO(a))return a
throw A.I(A.ab(a,"JSObject?"),new Error())},
iW(a,b){var s,r,q
for(s="",r="",q=0;q<a.length;++q,r=", ")s+=r+A.a4(a[q],b)
return s},
lw(a,b){var s,r,q,p,o,n,m=a.x,l=a.y
if(""===m)return"("+A.iW(l,b)+")"
s=l.length
r=m.split(",")
q=r.length-s
for(p="(",o="",n=0;n<s;++n,o=", "){p+=o
if(q===0)p+="{"
p+=A.a4(l[n],b)
if(q>=0)p+=" "+r[q];++q}return p+"})"},
iL(a3,a4,a5){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1=", ",a2=null
if(a5!=null){s=a5.length
if(a4==null)a4=A.d([],t.s)
else a2=a4.length
r=a4.length
for(q=s;q>0;--q)B.a.k(a4,"T"+(r+q))
for(p=t.X,o="<",n="",q=0;q<s;++q,n=a1){m=a4.length
l=m-1-q
if(!(l>=0))return A.l(a4,l)
o=o+n+a4[l]
k=a5[q]
j=k.w
if(!(j===2||j===3||j===4||j===5||k===p))o+=" extends "+A.a4(k,a4)}o+=">"}else o=""
p=a3.x
i=a3.y
h=i.a
g=h.length
f=i.b
e=f.length
d=i.c
c=d.length
b=A.a4(p,a4)
for(a="",a0="",q=0;q<g;++q,a0=a1)a+=a0+A.a4(h[q],a4)
if(e>0){a+=a0+"["
for(a0="",q=0;q<e;++q,a0=a1)a+=a0+A.a4(f[q],a4)
a+="]"}if(c>0){a+=a0+"{"
for(a0="",q=0;q<c;q+=3,a0=a1){a+=a0
if(d[q+1])a+="required "
a+=A.a4(d[q+2],a4)+" "+d[q]}a+="}"}if(a2!=null){a4.toString
a4.length=a2}return o+"("+a+") => "+b},
a4(a,b){var s,r,q,p,o,n,m,l=a.w
if(l===5)return"erased"
if(l===2)return"dynamic"
if(l===3)return"void"
if(l===1)return"Never"
if(l===4)return"any"
if(l===6){s=a.x
r=A.a4(s,b)
q=s.w
return(q===11||q===12?"("+r+")":r)+"?"}if(l===7)return"FutureOr<"+A.a4(a.x,b)+">"
if(l===8){p=A.lH(a.x)
o=a.y
return o.length>0?p+("<"+A.iW(o,b)+">"):p}if(l===10)return A.lw(a,b)
if(l===11)return A.iL(a,b,null)
if(l===12)return A.iL(a.x,b,a.y)
if(l===13){n=a.x
m=b.length
n=m-1-n
if(!(n>=0&&n<m))return A.l(b,n)
return b[n]}return"?"},
lH(a){var s=A.j9(a)
if(s!=null)return s
return"minified:"+a},
kD(a,b){var s=a.tR[b]
while(typeof s=="string")s=a.tR[s]
return s},
kC(a,b){var s,r,q,p,o,n=a.eT,m=n[b]
if(m==null)return A.fD(a,b,!1)
else if(typeof m=="number"){s=m
r=A.cS(a,5,"#")
q=A.fF(s)
for(p=0;p<s;++p)q[p]=r
o=A.cR(a,b,q)
n[b]=o
return o}else return m},
kB(a,b){return A.iF(a.tR,b)},
kA(a,b){return A.iF(a.eT,b)},
fD(a,b,c){var s,r=a.eC,q=r.get(b)
if(q!=null)return q
s=A.iD(a,null,b,!1)
r.set(b,s)
return s},
cT(a,b,c){var s,r,q=b.z
if(q==null)q=b.z=new Map()
s=q.get(c)
if(s!=null)return s
r=A.iD(a,b,c,!0)
q.set(c,r)
return r},
iE(a,b,c){var s,r,q,p=b.Q
if(p==null)p=b.Q=new Map()
s=c.as
r=p.get(s)
if(r!=null)return r
q=A.hk(a,b,c.w===9?c.y:[c])
p.set(s,q)
return q},
iD(a,b,c,d){return A.kq(A.kk(a,b,c,d))},
aY(a,b){b.a=A.lb
b.b=A.lc
return b},
cS(a,b,c){var s,r,q=a.eC.get(c)
if(q!=null)return q
s=new A.ag(null,null)
s.w=b
s.as=c
r=A.aY(a,s)
a.eC.set(c,r)
return r},
iB(a,b,c){var s,r=b.as+"?",q=a.eC.get(r)
if(q!=null)return q
s=A.ky(a,b,r,c)
a.eC.set(r,s)
return s},
ky(a,b,c,d){var s,r,q
if(d){s=b.w
r=!0
if(!A.bn(b))if(!(b===t.P||b===t.T))if(s!==6)r=s===7&&A.bX(b.x)
if(r)return b
else if(s===1)return t.P}q=new A.ag(null,null)
q.w=6
q.x=b
q.as=c
return A.aY(a,q)},
iA(a,b,c){var s,r=b.as+"/",q=a.eC.get(r)
if(q!=null)return q
s=A.kw(a,b,r,c)
a.eC.set(r,s)
return s},
kw(a,b,c,d){var s,r
if(d){s=b.w
if(A.bn(b)||b===t.K)return b
else if(s===1)return A.cR(a,"an",[b])
else if(b===t.P||b===t.T)return t.eH}r=new A.ag(null,null)
r.w=7
r.x=b
r.as=c
return A.aY(a,r)},
kz(a,b){var s,r,q=""+b+"^",p=a.eC.get(q)
if(p!=null)return p
s=new A.ag(null,null)
s.w=13
s.x=b
s.as=q
r=A.aY(a,s)
a.eC.set(q,r)
return r},
cQ(a){var s,r,q,p=a.length
for(s="",r="",q=0;q<p;++q,r=",")s+=r+a[q].as
return s},
kv(a){var s,r,q,p,o,n=a.length
for(s="",r="",q=0;q<n;q+=3,r=","){p=a[q]
o=a[q+1]?"!":":"
s+=r+p+o+a[q+2].as}return s},
cR(a,b,c){var s,r,q,p=b
if(c.length>0)p+="<"+A.cQ(c)+">"
s=a.eC.get(p)
if(s!=null)return s
r=new A.ag(null,null)
r.w=8
r.x=b
r.y=c
if(c.length>0)r.c=c[0]
r.as=p
q=A.aY(a,r)
a.eC.set(p,q)
return q},
hk(a,b,c){var s,r,q,p,o,n
if(b.w===9){s=b.x
r=b.y.concat(c)}else{r=c
s=b}q=s.as+(";<"+A.cQ(r)+">")
p=a.eC.get(q)
if(p!=null)return p
o=new A.ag(null,null)
o.w=9
o.x=s
o.y=r
o.as=q
n=A.aY(a,o)
a.eC.set(q,n)
return n},
iC(a,b,c){var s,r,q="+"+(b+"("+A.cQ(c)+")"),p=a.eC.get(q)
if(p!=null)return p
s=new A.ag(null,null)
s.w=10
s.x=b
s.y=c
s.as=q
r=A.aY(a,s)
a.eC.set(q,r)
return r},
iz(a,b,c){var s,r,q,p,o,n=b.as,m=c.a,l=m.length,k=c.b,j=k.length,i=c.c,h=i.length,g="("+A.cQ(m)
if(j>0){s=l>0?",":""
g+=s+"["+A.cQ(k)+"]"}if(h>0){s=l>0?",":""
g+=s+"{"+A.kv(i)+"}"}r=n+(g+")")
q=a.eC.get(r)
if(q!=null)return q
p=new A.ag(null,null)
p.w=11
p.x=b
p.y=c
p.as=r
o=A.aY(a,p)
a.eC.set(r,o)
return o},
hl(a,b,c,d){var s,r=b.as+("<"+A.cQ(c)+">"),q=a.eC.get(r)
if(q!=null)return q
s=A.kx(a,b,c,r,d)
a.eC.set(r,s)
return s},
kx(a,b,c,d,e){var s,r,q,p,o,n,m,l
if(e){s=c.length
r=A.fF(s)
for(q=0,p=0;p<s;++p){o=c[p]
if(o.w===1){r[p]=o;++q}}if(q>0){n=A.bi(a,b,r,0)
m=A.bS(a,c,r,0)
return A.hl(a,n,m,c!==m)}}l=new A.ag(null,null)
l.w=12
l.x=b
l.y=c
l.as=d
return A.aY(a,l)},
kk(a,b,c,d){return{u:a,e:b,r:c,s:[],p:0,n:d}},
kq(a){var s,r,q,p,o,n,m,l=a.r,k=a.s
for(s=l.length,r=0;r<s;){q=l.charCodeAt(r)
if(q>=48&&q<=57)r=A.km(r+1,q,l,k)
else if((((q|32)>>>0)-97&65535)<26||q===95||q===36||q===124)r=A.ix(a,r,l,k,!1)
else if(q===46)r=A.ix(a,r,l,k,!0)
else{++r
switch(q){case 44:break
case 58:k.push(!1)
break
case 33:k.push(!0)
break
case 59:k.push(A.bg(a.u,a.e,k.pop()))
break
case 94:k.push(A.kz(a.u,k.pop()))
break
case 35:k.push(A.cS(a.u,5,"#"))
break
case 64:k.push(A.cS(a.u,2,"@"))
break
case 126:k.push(A.cS(a.u,3,"~"))
break
case 60:k.push(a.p)
a.p=k.length
break
case 62:A.ko(a,k)
break
case 38:A.kn(a,k)
break
case 63:p=a.u
k.push(A.iB(p,A.bg(p,a.e,k.pop()),a.n))
break
case 47:p=a.u
k.push(A.iA(p,A.bg(p,a.e,k.pop()),a.n))
break
case 40:k.push(-3)
k.push(a.p)
a.p=k.length
break
case 41:A.kl(a,k)
break
case 91:k.push(a.p)
a.p=k.length
break
case 93:o=k.splice(a.p)
A.iy(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-1)
break
case 123:k.push(a.p)
a.p=k.length
break
case 125:o=k.splice(a.p)
A.kr(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-2)
break
case 43:n=l.indexOf("(",r)
k.push(l.substring(r,n))
k.push(-4)
k.push(a.p)
a.p=k.length
r=n+1
break
default:throw"Bad character "+q}}}m=k.pop()
return A.bg(a.u,a.e,m)},
km(a,b,c,d){var s,r,q=b-48
for(s=c.length;a<s;++a){r=c.charCodeAt(a)
if(!(r>=48&&r<=57))break
q=q*10+(r-48)}d.push(q)
return a},
ix(a,b,c,d,e){var s,r,q,p,o,n,m=b+1
for(s=c.length;m<s;++m){r=c.charCodeAt(m)
if(r===46){if(e)break
e=!0}else{if(!((((r|32)>>>0)-97&65535)<26||r===95||r===36||r===124))q=r>=48&&r<=57
else q=!0
if(!q)break}}p=c.substring(b,m)
if(e){s=a.u
o=a.e
if(o.w===9)o=o.x
n=A.kD(s,o.x)[p]
if(n==null)A.h2('No "'+p+'" in "'+A.k0(o)+'"')
d.push(A.cT(s,o,n))}else d.push(p)
return m},
ko(a,b){var s,r=a.u,q=A.iw(a,b),p=b.pop()
if(typeof p=="string")b.push(A.cR(r,p,q))
else{s=A.bg(r,a.e,p)
switch(s.w){case 11:b.push(A.hl(r,s,q,a.n))
break
default:b.push(A.hk(r,s,q))
break}}},
kl(a,b){var s,r,q,p=a.u,o=b.pop(),n=null,m=null
if(typeof o=="number")switch(o){case-1:n=b.pop()
break
case-2:m=b.pop()
break
default:b.push(o)
break}else b.push(o)
s=A.iw(a,b)
o=b.pop()
switch(o){case-3:o=b.pop()
if(n==null)n=p.sEA
if(m==null)m=p.sEA
r=A.bg(p,a.e,o)
q=new A.ea()
q.a=s
q.b=n
q.c=m
b.push(A.iz(p,r,q))
return
case-4:b.push(A.iC(p,b.pop(),s))
return
default:throw A.e(A.d0("Unexpected state under `()`: "+A.n(o)))}},
kn(a,b){var s=b.pop()
if(0===s){b.push(A.cS(a.u,1,"0&"))
return}if(1===s){b.push(A.cS(a.u,4,"1&"))
return}throw A.e(A.d0("Unexpected extended operation "+A.n(s)))},
iw(a,b){var s=b.splice(a.p)
A.iy(a.u,a.e,s)
a.p=b.pop()
return s},
bg(a,b,c){if(typeof c=="string")return A.cR(a,c,a.sEA)
else if(typeof c=="number"){b.toString
return A.kp(a,b,c)}else return c},
iy(a,b,c){var s,r=c.length
for(s=0;s<r;++s)c[s]=A.bg(a,b,c[s])},
kr(a,b,c){var s,r=c.length
for(s=2;s<r;s+=3)c[s]=A.bg(a,b,c[s])},
kp(a,b,c){var s,r,q=b.w
if(q===9){if(c===0)return b.x
s=b.y
r=s.length
if(c<=r)return s[c-1]
c-=r
b=b.x
q=b.w}else if(c===0)return b
if(q!==8)throw A.e(A.d0("Indexed base must be an interface type"))
s=b.y
if(c<=s.length)return s[c-1]
throw A.e(A.d0("Bad index "+c+" for "+b.i(0)))},
m1(a,b,c){var s,r=b.d
if(r==null)r=b.d=new Map()
s=r.get(c)
if(s==null){s=A.L(a,b,null,c,null)
r.set(c,s)}return s},
L(a,b,c,d,e){var s,r,q,p,o,n,m,l,k,j,i
if(b===d)return!0
if(A.bn(d))return!0
s=b.w
if(s===4)return!0
if(A.bn(b))return!1
if(b.w===1)return!0
r=s===13
if(r)if(A.L(a,c[b.x],c,d,e))return!0
q=d.w
p=t.P
if(b===p||b===t.T){if(q===7)return A.L(a,b,c,d.x,e)
return d===p||d===t.T||q===6}if(d===t.K){if(s===7)return A.L(a,b.x,c,d,e)
return s!==6}if(s===7){if(!A.L(a,b.x,c,d,e))return!1
return A.L(a,A.hf(a,b),c,d,e)}if(s===6)return A.L(a,p,c,d,e)&&A.L(a,b.x,c,d,e)
if(q===7){if(A.L(a,b,c,d.x,e))return!0
return A.L(a,b,c,A.hf(a,d),e)}if(q===6)return A.L(a,b,c,p,e)||A.L(a,b,c,d.x,e)
if(r)return!1
p=s!==11
if((!p||s===12)&&d===t.Z)return!0
o=s===10
if(o&&d===t.gT)return!0
if(q===12){if(b===t.g)return!0
if(s!==12)return!1
n=b.y
m=d.y
l=n.length
if(l!==m.length)return!1
c=c==null?n:n.concat(c)
e=e==null?m:m.concat(e)
for(k=0;k<l;++k){j=n[k]
i=m[k]
if(!A.L(a,j,c,i,e)||!A.L(a,i,e,j,c))return!1}return A.iM(a,b.x,c,d.x,e)}if(q===11){if(b===t.g)return!0
if(p)return!1
return A.iM(a,b,c,d,e)}if(s===8){if(q!==8)return!1
return A.lj(a,b,c,d,e)}if(o&&q===10)return A.lo(a,b,c,d,e)
return!1},
iM(a3,a4,a5,a6,a7){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1,a2
if(!A.L(a3,a4.x,a5,a6.x,a7))return!1
s=a4.y
r=a6.y
q=s.a
p=r.a
o=q.length
n=p.length
if(o>n)return!1
m=n-o
l=s.b
k=r.b
j=l.length
i=k.length
if(o+j<n+i)return!1
for(h=0;h<o;++h){g=q[h]
if(!A.L(a3,p[h],a7,g,a5))return!1}for(h=0;h<m;++h){g=l[h]
if(!A.L(a3,p[o+h],a7,g,a5))return!1}for(h=0;h<i;++h){g=l[m+h]
if(!A.L(a3,k[h],a7,g,a5))return!1}f=s.c
e=r.c
d=f.length
c=e.length
for(b=0,a=0;a<c;a+=3){a0=e[a]
for(;;){if(b>=d)return!1
a1=f[b]
b+=3
if(a0<a1)return!1
a2=f[b-2]
if(a1<a0){if(a2)return!1
continue}g=e[a+1]
if(a2&&!g)return!1
g=f[b-1]
if(!A.L(a3,e[a+2],a7,g,a5))return!1
break}}while(b<d){if(f[b+1])return!1
b+=3}return!0},
lj(a,b,c,d,e){var s,r,q,p,o,n=b.x,m=d.x
while(n!==m){s=a.tR[n]
if(s==null)return!1
if(typeof s=="string"){n=s
continue}r=s[m]
if(r==null)return!1
q=r.length
p=q>0?new Array(q):v.typeUniverse.sEA
for(o=0;o<q;++o)p[o]=A.cT(a,b,r[o])
return A.iG(a,p,null,c,d.y,e)}return A.iG(a,b.y,null,c,d.y,e)},
iG(a,b,c,d,e,f){var s,r=b.length
for(s=0;s<r;++s)if(!A.L(a,b[s],d,e[s],f))return!1
return!0},
lo(a,b,c,d,e){var s,r=b.y,q=d.y,p=r.length
if(p!==q.length)return!1
if(b.x!==d.x)return!1
for(s=0;s<p;++s)if(!A.L(a,r[s],c,q[s],e))return!1
return!0},
bX(a){var s=a.w,r=!0
if(!(a===t.P||a===t.T))if(!A.bn(a))if(s!==6)r=s===7&&A.bX(a.x)
return r},
bn(a){var s=a.w
return s===2||s===3||s===4||s===5||a===t.X},
iF(a,b){var s,r,q=Object.keys(b),p=q.length
for(s=0;s<p;++s){r=q[s]
a[r]=b[r]}},
fF(a){return a>0?new Array(a):v.typeUniverse.sEA},
ag:function ag(a,b){var _=this
_.a=a
_.b=b
_.r=_.f=_.d=_.c=null
_.w=0
_.as=_.Q=_.z=_.y=_.x=null},
ea:function ea(){this.c=this.b=this.a=null},
eg:function eg(a){this.a=a},
e9:function e9(){},
cP:function cP(a){this.a=a},
kd(){var s,r,q
if(self.scheduleImmediate!=null)return A.lM()
if(self.MutationObserver!=null&&self.document!=null){s={}
r=self.document.createElement("div")
q=self.document.createElement("span")
s.a=null
new self.MutationObserver(A.bj(new A.fb(s),1)).observe(r,{childList:true})
return new A.fa(s,r,q)}else if(self.setImmediate!=null)return A.lN()
return A.lO()},
ke(a){self.scheduleImmediate(A.bj(new A.fc(t.M.a(a)),0))},
kf(a){self.setImmediate(A.bj(new A.fd(t.M.a(a)),0))},
kg(a){A.hh(B.m,t.M.a(a))},
hh(a,b){return A.kt(a.a/1000|0,b)},
ie(a,b){return A.ku(a.a/1000|0,b)},
kt(a,b){var s=new A.cO(!0)
s.du(a,b)
return s},
ku(a,b){var s=new A.cO(!1)
s.dv(a,b)
return s},
bP(a){return new A.cE(new A.C($.y,a.h("C<0>")),a.h("cE<0>"))},
bO(a,b){a.$2(0,null)
b.b=!0
return b.a},
aG(a,b){A.kI(a,b)},
bN(a,b){b.a4(a)},
bM(a,b){b.bq(A.b0(a),A.aZ(a))},
kI(a,b){var s,r,q=new A.fH(b),p=new A.fI(b)
if(a instanceof A.C)a.cv(q,p,t.z)
else{s=t.z
if(a instanceof A.C)a.bG(q,p,s)
else{r=new A.C($.y,t._)
r.a=8
r.c=a
r.cv(q,p,s)}}},
bT(a){var s=function(b,c){return function(d,e){while(true){try{b(d,e)
break}catch(r){e=r
d=c}}}}(a,1)
return $.y.cV(new A.fQ(s),t.H,t.S,t.z)},
h6(a){var s
if(t.C.b(a)){s=a.ga8()
if(s!=null)return s}return B.j},
jH(a,b){var s
if(!b.b(null))throw A.e(A.eo(null,"computation","The type parameter is not nullable"))
s=new A.C($.y,b.h("C<0>"))
A.id(a,new A.eq(null,s,b))
return s},
le(a,b){if($.y===B.h)return null
return null},
lf(a,b){if($.y!==B.h)A.le(a,b)
if(b==null)if(t.C.b(a)){b=a.ga8()
if(b==null){A.i8(a,B.j)
b=B.j}}else b=B.j
else if(t.C.b(a))A.i8(a,b)
return new A.a6(a,b)},
fk(a,b,c){var s,r,q,p,o={},n=o.a=a
for(s=t._;r=n.a,(r&4)!==0;n=a){a=s.a(n.c)
o.a=a}if(n===b){s=A.k2()
b.b3(new A.a6(new A.am(!0,n,null,"Cannot complete a future with itself"),s))
return}q=b.a&1
s=n.a=r|q
if((s&24)===0){p=t.F.a(b.c)
b.a=b.a&1|4
b.c=n
n.cg(p)
return}if(!c)if(b.c==null)n=(s&16)===0||q!==0
else n=!1
else n=!0
if(n){p=b.ad()
b.aw(o.a)
A.be(b,p)
return}b.a^=2
A.ej(null,null,b.b,t.M.a(new A.fl(o,b)))},
be(a,b){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d={},c=d.a=a
for(s=t.n,r=t.F;;){q={}
p=c.a
o=(p&16)===0
n=!o
if(b==null){if(n&&(p&1)===0){m=s.a(c.c)
A.fN(m.a,m.b)}return}q.a=b
l=b.a
for(c=b;l!=null;c=l,l=k){c.a=null
A.be(d.a,c)
q.a=l
k=l.a}p=d.a
j=p.c
q.b=n
q.c=j
if(o){i=c.c
i=(i&1)!==0||(i&15)===8}else i=!0
if(i){h=c.b.b
if(n){p=p.b===h
p=!(p||p)}else p=!1
if(p){s.a(j)
A.fN(j.a,j.b)
return}g=$.y
if(g!==h)$.y=h
else g=null
c=c.c
if((c&15)===8)new A.fp(q,d,n).$0()
else if(o){if((c&1)!==0)new A.fo(q,j).$0()}else if((c&2)!==0)new A.fn(d,q).$0()
if(g!=null)$.y=g
c=q.c
if(c instanceof A.C){p=q.a.$ti
p=p.h("an<2>").b(c)||!p.y[1].b(c)}else p=!1
if(p){f=q.a.b
if((c.a&24)!==0){e=r.a(f.c)
f.c=null
b=f.aC(e)
f.a=c.a&30|f.a&1
f.c=c.c
d.a=c
continue}else A.fk(c,f,!0)
return}}f=q.a.b
e=r.a(f.c)
f.c=null
b=f.aC(e)
c=q.b
p=q.c
if(!c){f.$ti.c.a(p)
f.a=8
f.c=p}else{s.a(p)
f.a=f.a&1|16
f.c=p}d.a=f
c=f}},
lx(a,b){var s
if(t.Q.b(a))return b.cV(a,t.z,t.K,t.l)
s=t.w
if(s.b(a))return s.a(a)
throw A.e(A.eo(a,"onError",u.c))},
lu(){var s,r
for(s=$.bQ;s!=null;s=$.bQ){$.cW=null
r=s.b
$.bQ=r
if(r==null)$.cV=null
s.a.$0()}},
lD(){$.hu=!0
try{A.lu()}finally{$.cW=null
$.hu=!1
if($.bQ!=null)$.hI().$1(A.j1())}},
iX(a){var s=new A.e8(a),r=$.cV
if(r==null){$.bQ=$.cV=s
if(!$.hu)$.hI().$1(A.j1())}else $.cV=r.b=s},
lA(a){var s,r,q,p=$.bQ
if(p==null){A.iX(a)
$.cW=$.cV
return}s=new A.e8(a)
r=$.cW
if(r==null){s.b=p
$.bQ=$.cW=s}else{q=r.b
s.b=q
$.cW=r.b=s
if(q==null)$.cV=s}},
mk(a,b){A.hx(a,"stream",t.K)
return new A.ee(b.h("ee<0>"))},
id(a,b){var s=$.y
if(s===B.h)return A.hh(a,t.M.a(b))
return A.hh(a,t.M.a(s.cF(b)))},
k4(a,b){var s=$.y
if(s===B.h)return A.ie(a,t.k.a(b))
return A.ie(a,t.k.a(s.ee(b,t.p)))},
fN(a,b){A.lA(new A.fO(a,b))},
iU(a,b,c,d,e){var s,r=$.y
if(r===c)return d.$0()
$.y=c
s=r
try{r=d.$0()
return r}finally{$.y=s}},
iV(a,b,c,d,e,f,g){var s,r=$.y
if(r===c)return d.$1(e)
$.y=c
s=r
try{r=d.$1(e)
return r}finally{$.y=s}},
ly(a,b,c,d,e,f,g,h,i){var s,r=$.y
if(r===c)return d.$2(e,f)
$.y=c
s=r
try{r=d.$2(e,f)
return r}finally{$.y=s}},
ej(a,b,c,d){t.M.a(d)
if(B.h!==c){d=c.cF(d)
d=d}A.iX(d)},
fb:function fb(a){this.a=a},
fa:function fa(a,b,c){this.a=a
this.b=b
this.c=c},
fc:function fc(a){this.a=a},
fd:function fd(a){this.a=a},
cO:function cO(a){this.a=a
this.b=null
this.c=0},
fB:function fB(a,b){this.a=a
this.b=b},
fA:function fA(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
cE:function cE(a,b){this.a=a
this.b=!1
this.$ti=b},
fH:function fH(a){this.a=a},
fI:function fI(a){this.a=a},
fQ:function fQ(a){this.a=a},
a6:function a6(a,b){this.a=a
this.b=b},
eq:function eq(a,b,c){this.a=a
this.b=b
this.c=c},
cF:function cF(){},
aF:function aF(a,b){this.a=a
this.$ti=b},
bd:function bd(a,b,c,d,e){var _=this
_.a=null
_.b=a
_.c=b
_.d=c
_.e=d
_.$ti=e},
C:function C(a,b){var _=this
_.a=0
_.b=a
_.c=null
_.$ti=b},
fh:function fh(a,b){this.a=a
this.b=b},
fm:function fm(a,b){this.a=a
this.b=b},
fl:function fl(a,b){this.a=a
this.b=b},
fj:function fj(a,b){this.a=a
this.b=b},
fi:function fi(a,b){this.a=a
this.b=b},
fp:function fp(a,b,c){this.a=a
this.b=b
this.c=c},
fq:function fq(a,b){this.a=a
this.b=b},
fr:function fr(a){this.a=a},
fo:function fo(a,b){this.a=a
this.b=b},
fn:function fn(a,b){this.a=a
this.b=b},
e8:function e8(a){this.a=a
this.b=null},
ee:function ee(a){this.$ti=a},
cU:function cU(){},
ed:function ed(){},
fy:function fy(a,b){this.a=a
this.b=b},
fz:function fz(a,b,c){this.a=a
this.b=b
this.c=c},
fO:function fO(a,b){this.a=a
this.b=b},
hZ(a,b,c){return b.h("@<0>").D(c).h("hb<1,2>").a(A.j3(a,new A.au(b.h("@<0>").D(c).h("au<1,2>"))))},
bw(a,b){return new A.au(a.h("@<0>").D(b).h("au<1,2>"))},
hc(a){return new A.cG(a.h("cG<0>"))},
hj(){var s=Object.create(null)
s["<non-identifier-key>"]=s
delete s["<non-identifier-key>"]
return s},
iv(a,b,c){var s=new A.bf(a,b,c.h("bf<0>"))
s.c=a.e
return s},
jM(a,b,c){var s
A.cm(b,"index")
s=a.length
if(b>=s)return null
if(!(b>=0))return A.l(a,b)
return a[b]},
he(a){var s,r
if(A.hC(a))return"{...}"
s=new A.Y("")
try{r={}
B.a.k($.a5,a)
s.a+="{"
r.a=!0
a.Z(0,new A.ew(r,s))
s.a+="}"}finally{if(0>=$.a5.length)return A.l($.a5,-1)
$.a5.pop()}r=s.a
return r.charCodeAt(0)==0?r:r},
cG:function cG(a){var _=this
_.a=0
_.f=_.e=_.d=_.c=_.b=null
_.r=0
_.$ti=a},
ec:function ec(a){this.a=a
this.c=this.b=null},
bf:function bf(a,b,c){var _=this
_.a=a
_.b=b
_.d=_.c=null
_.$ti=c},
q:function q(){},
bx:function bx(){},
ew:function ew(a,b){this.a=a
this.b=b},
bz:function bz(){},
cM:function cM(){},
hX(a,b,c){return new A.cc(a,b)},
kO(a){return a.f4()},
ki(a,b){return new A.fu(a,[],A.lR())},
kj(a,b,c){var s,r=new A.Y(""),q=A.ki(r,b)
q.aR(a)
s=r.a
return s.charCodeAt(0)==0?s:s},
fC:function fC(){},
d3:function d3(){},
d5:function d5(){},
cc:function cc(a,b){this.a=a
this.b=b},
de:function de(a,b){this.a=a
this.b=b},
dd:function dd(){},
es:function es(a){this.b=a},
fv:function fv(){},
fw:function fw(a,b){this.a=a
this.b=b},
fu:function fu(a,b,c){this.c=a
this.a=b
this.b=c},
et:function et(){},
jD(a,b){a=A.I(a,new Error())
if(a==null)a=A.bL(a)
a.stack=b.i(0)
throw a},
hd(a,b,c,d){var s,r=J.hW(a,d)
if(a!==0&&b!=null)for(s=0;s<a;++s)r[s]=b
return r},
jR(a,b,c){var s,r,q=A.d([],c.h("p<0>"))
for(s=a.length,r=0;r<a.length;a.length===s||(0,A.u)(a),++r)B.a.k(q,c.a(a[r]))
q.$flags=1
return q},
a1(a,b){var s,r
if(Array.isArray(a))return A.d(a.slice(0),b.h("p<0>"))
s=A.d([],b.h("p<0>"))
for(r=J.h5(a);r.q();)B.a.k(s,r.gA())
return s},
ib(a,b,c){var s=J.h5(b)
if(!s.q())return a
if(c.length===0){do a+=A.n(s.gA())
while(s.q())}else{a+=A.n(s.gA())
while(s.q())a=a+c+A.n(s.gA())}return a},
k2(){return A.aZ(new Error())},
jC(a){var s=Math.abs(a),r=a<0?"-":""
if(s>=1000)return""+a
if(s>=100)return r+"0"+s
if(s>=10)return r+"00"+s
return r+"000"+s},
hU(a){if(a>=100)return""+a
if(a>=10)return"0"+a
return"00"+a},
d6(a){if(a>=10)return""+a
return"0"+a},
d7(a){if(typeof a=="number"||A.ht(a)||a==null)return J.cZ(a)
if(typeof a=="string")return JSON.stringify(a)
return A.i7(a)},
jE(a,b){A.hx(a,"error",t.K)
A.hx(b,"stackTrace",t.l)
A.jD(a,b)},
d0(a){return new A.d_(a)},
en(a,b){return new A.am(!1,null,b,a)},
eo(a,b,c){return new A.am(!0,a,b,c)},
hO(a,b,c){return a},
i9(a,b){return new A.cl(null,null,!0,a,b,"Value not in range")},
ax(a,b,c,d,e){return new A.cl(b,c,!0,a,d,"Invalid value")},
du(a,b,c){if(0>a||a>c)throw A.e(A.ax(a,0,c,"start",null))
if(b!=null){if(a>b||b>c)throw A.e(A.ax(b,a,c,"end",null))
return b}return c},
cm(a,b){if(a<0)throw A.e(A.ax(a,0,null,b,null))
return a},
h7(a,b,c,d){return new A.d8(b,!0,a,d,"Index out of range")},
aT(a){return new A.cu(a)},
ih(a){return new A.dC(a)},
dy(a){return new A.bA(a)},
a7(a){return new A.d4(a)},
jN(a,b,c){var s,r
if(A.hC(a)){if(b==="("&&c===")")return"(...)"
return b+"..."+c}s=A.d([],t.s)
B.a.k($.a5,a)
try{A.ls(a,s)}finally{if(0>=$.a5.length)return A.l($.a5,-1)
$.a5.pop()}r=A.ib(b,t.hf.a(s),", ")+c
return r.charCodeAt(0)==0?r:r},
h8(a,b,c){var s,r
if(A.hC(a))return b+"..."+c
s=new A.Y(b)
B.a.k($.a5,a)
try{r=s
r.a=A.ib(r.a,a,", ")}finally{if(0>=$.a5.length)return A.l($.a5,-1)
$.a5.pop()}s.a+=c
r=s.a
return r.charCodeAt(0)==0?r:r},
ls(a,b){var s,r,q,p,o,n,m,l=a.gC(a),k=0,j=0
for(;;){if(!(k<80||j<3))break
if(!l.q())return
s=A.n(l.gA())
B.a.k(b,s)
k+=s.length+2;++j}if(!l.q()){if(j<=5)return
if(0>=b.length)return A.l(b,-1)
r=b.pop()
if(0>=b.length)return A.l(b,-1)
q=b.pop()}else{p=l.gA();++j
if(!l.q()){if(j<=4){B.a.k(b,A.n(p))
return}r=A.n(p)
if(0>=b.length)return A.l(b,-1)
q=b.pop()
k+=r.length+2}else{o=l.gA();++j
for(;l.q();p=o,o=n){n=l.gA();++j
if(j>100){for(;;){if(!(k>75&&j>3))break
if(0>=b.length)return A.l(b,-1)
k-=b.pop().length+2;--j}B.a.k(b,"...")
return}}q=A.n(p)
r=A.n(o)
k+=r.length+q.length+4}}if(j>b.length+2){k+=5
m="..."}else m=null
for(;;){if(!(k>80&&b.length>3))break
if(0>=b.length)return A.l(b,-1)
k-=b.pop().length+2
if(m==null){k+=5
m="..."}}if(m!=null)B.a.k(b,m)
B.a.k(b,q)
B.a.k(b,r)},
dp(a,b,c,d){var s
if(B.i===c){s=B.c.gp(a)
b=J.af(b)
return A.eM(A.ay(A.ay($.el(),s),b))}if(B.i===d){s=B.c.gp(a)
b=J.af(b)
c=J.af(c)
return A.eM(A.ay(A.ay(A.ay($.el(),s),b),c))}s=B.c.gp(a)
b=J.af(b)
c=J.af(c)
d=J.af(d)
d=A.eM(A.ay(A.ay(A.ay(A.ay($.el(),s),b),c),d))
return d},
jU(a){var s,r,q=$.el()
for(s=a.length,r=0;r<a.length;a.length===s||(0,A.u)(a),++r)q=A.ay(q,J.af(a[r]))
return A.eM(q)},
aM:function aM(a,b,c){this.a=a
this.b=b
this.c=c},
aN:function aN(a){this.a=a},
ff:function ff(){},
A:function A(){},
d_:function d_(a){this.a=a},
az:function az(){},
am:function am(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
cl:function cl(a,b,c,d,e,f){var _=this
_.e=a
_.f=b
_.a=c
_.b=d
_.c=e
_.d=f},
d8:function d8(a,b,c,d,e){var _=this
_.f=a
_.a=b
_.b=c
_.c=d
_.d=e},
cu:function cu(a){this.a=a},
dC:function dC(a){this.a=a},
bA:function bA(a){this.a=a},
d4:function d4(a){this.a=a},
dq:function dq(){},
cq:function cq(){},
fg:function fg(a){this.a=a},
h:function h(){},
N:function N(){},
w:function w(){},
ef:function ef(){},
eL:function eL(){this.b=this.a=0},
dw:function dw(a){this.a=a},
by:function by(a){var _=this
_.a=a
_.c=_.b=0
_.d=-1},
Y:function Y(a){this.a=a},
ez:function ez(a){this.a=a},
kJ(a,b,c){t.Z.a(a)
if(A.c(c)>=1)return a.$1(b)
return a.$0()},
l9(a,b){return a[b]},
ai(a,b,c,d){return d.a(a[b].apply(a,c))},
kK(a,b,c){return c.a(a[b]())},
m6(a,b){var s=new A.C($.y,b.h("C<0>")),r=new A.aF(s,b.h("aF<0>"))
a.then(A.bj(new A.h0(r,b),1),A.bj(new A.h1(r),1))
return s},
h0:function h0(a,b){this.a=a
this.b=b},
h1:function h1(a){this.a=a},
v(a,b,c){return new A.b1(a,b,c)},
aR(a,b,c){return new A.aQ(a,b,c)},
jS(){var s=new A.df(A.b9(A.bU(74,!0,!1),11),A.b9(A.bU(74,!1,!1),9),A.b9(A.bU(72,!0,!1),17),A.b9(A.bU(72,!0,!0),24),A.d([],t.gL))
s.dn()
return s},
k_(){var s="Pizzeria Da Lucia",r=541072960,q=new A.F(s,$.aK(),A.d([],t.e),null,-1,B.e,B.d,r,B.d,new A.G(0,0,0,0),B.d,A.d([],t.y))
q.S(null,-1,B.e,B.d,r)
q.dt(null,-1,s,B.e,B.d,r)
if($.bY==null)$.bY=q
q.dq()
return q},
m3(){new A.dv(A.d([],t.y)).ds()
if($.bY==null)A.ar("error","[error]: ","There is no WxFrame for WxApp to show!")
A.aq()},
b1:function b1(a,b,c){this.a=a
this.b=b
this.c=c},
aQ:function aQ(a,b,c){this.a=a
this.b=b
this.c=c},
cr:function cr(a,b,c,d,e,f,g,h,i,j){var _=this
_.d=$
_.e=a
_.f=b
_.r=c
_.w=d
_.x=e
_.y=f
_.z=g
_.Q=h
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=i
_.a=j
_.c=null},
cn:function cn(a,b,c,d,e,f,g,h,i,j,k){var _=this
_.cQ=_.cP=_.cO=_.cN=$
_.cR=null
_.RG=$
_.ry=_.rx=0
_.y1=a
_.d=$
_.e=b
_.f=c
_.r=d
_.w=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=j
_.a=k
_.c=null},
eJ:function eJ(a,b,c){this.a=a
this.b=b
this.c=c},
df:function df(a,b,c,d,e){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=$
_.f=e},
ex:function ex(a){this.a=a},
ey:function ey(a){this.a=a},
F:function F(a,b,c,d,e,f,g,h,i,j,k,l){var _=this
_.cM=null
_.t=a
_.O=b
_.H=!1
_.d=$
_.e=c
_.f=d
_.r=e
_.w=f
_.x=g
_.y=h
_.z=i
_.Q=j
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=k
_.a=l
_.c=null},
eI:function eI(){},
eD:function eD(a){this.a=a},
eE:function eE(a){this.a=a},
eF:function eF(a){this.a=a},
eG:function eG(a){this.a=a},
eH:function eH(a){this.a=a},
dv:function dv(a){var _=this
_.f=_.e=$
_.a=a
_.c=null},
ij(a,b){return new A.J(a,b)},
bD(a,b,c,d){return new A.j(a,b,c,d)},
kc(a,b){return new A.o(a,b)},
kb(a,b){return new A.r(a,b)},
t(a){var s,r
if(isNaN(a)||a==1/0||a==-1/0)return"0"
s=B.b.u(a*1e4)
if(B.c.bL(s,1e4)===0)return B.c.i(B.c.J(s,1e4))
r=B.b.an(s/1e4,4)
while(B.f.cL(r,"0"))r=B.f.a0(r,0,r.length-1)
return B.f.cL(r,".")?B.f.a0(r,0,r.length-1):r},
fM(a){var s,r,q,p
for(s=new A.c2(a),r=t.V,s=new A.av(s,s.gl(0),r.h("av<q.E>")),r=r.h("q.E"),q="<FEFF";s.q();){p=s.d
q+=B.f.al(B.c.cX(p==null?r.a(p):p,16),4,"0").toUpperCase()}s=q+">"
return s.charCodeAt(0)==0?s:s},
lv(a){var s=new A.fL(),r=a.eQ()
return"(D:"+A.i6(r)+A.n(s.$1(A.i4(r)))+A.n(s.$1(A.i1(r)))+A.n(s.$1(A.i2(r)))+A.n(s.$1(A.i3(r)))+A.n(s.$1(A.i5(r)))+"Z)"},
hv(a){var s=a.a|a.b<<8|a.c<<16|a.d<<24
return A.d([s&255,s>>>8&255,s>>>16&255,s>>>24&255],t.t)},
iS(a,b){var s=A.hv(a)
return A.t(s[0]/255)+" "+A.t(s[1]/255)+" "+A.t(s[2]/255)+" "+b+"\n"},
hm(){return new A.ei(new A.j(0,0,0,255),new A.j(255,255,255,255),A.b9("Helvetica",10),new A.j(0,0,0,255),B.M)},
im(){return new A.bE(new A.Y(""),A.U(new v.G.Path2D()))},
iZ(a){var s
if(a>=32&&a<127)return a
if(a>=160&&a<=255)return a
s=B.Y.j(0,a)
return s==null?63:s},
bU(a,b,c){var s
if(a===72){if(b&&c)return"Times-BoldItalic"
if(b)return"Times-Bold"
if(c)return"Times-Italic"
return"Times-Roman"}s=a===76||a===75?"Courier":"Helvetica"
if(b&&c)return s+"-BoldOblique"
if(b)return s+"-Bold"
if(c)return s+"-Oblique"
return s},
b9(a,b){var s=B.X.j(0,a)
return new A.eY(a,b,s==null?B.D:s)},
ip(a,b,c){return new A.bb(a,c,b)},
eV(a,b){var s=new A.a9()
s.b=a
s.a=b
s.e=65e3
return s},
il(a){var s=new A.dP()
s.b=118
s.a=a
return s},
k9(a,b,c){var s=new A.dR()
s.b=a
s.a=0
return s},
ir(a){var s=new A.e6()
s.b=119
s.a=a
s.e=65e3
return s},
ik(){var s=new A.dG(A.d([],t.J),$.aJ(),$.aK())
s.f=8
return s},
f4(){var s=new A.e_(A.d([],t.J),$.aJ(),$.aK())
s.f=4
return s},
iq(a,b,c){var s=new A.cD(c,A.d([],t.e),a,b,B.e,B.d,0,B.d,new A.G(0,0,0,0),B.d,A.d([],t.y))
s.S(a,b,B.e,B.d,0)
s.d9(c)
return s},
aW(a,b,c,d){var s=new A.e4(A.d([],t.e),a,b,B.e,B.d,d,B.d,new A.G(0,0,0,0),B.d,A.d([],t.y))
s.S(a,b,B.e,B.d,d)
s.bn()
s.aU(c)
return s},
aq(){if($.hr)return
$.hr=!0
A.id(B.m,A.mc())},
lz(){var s,r,q,p,o,n
$.hr=!1
A.l3()
s=A.a1($.aI,t.h8)
r=s.length
q=!1
p=0
for(;p<s.length;s.length===r||(0,A.u)(s),++p){o=s[p]
if(o.ch)continue
o.cr()
if(o.cn())q=!0}n=A.il(0)
$.bK.a5()
$.bK.a5().v(n)
if(q)A.aq()},
kV(a){var s,r,q,p,o
A.U(a)
try{p=A.kW(a)
return p}catch(o){s=A.b0(o)
r=A.aZ(o)
q=a
p=v.G.wxc
p.consoleLog("error",'wxDart Web: exception while handling "'+A.H(q.type)+'" (window '+A.c(q.id)+"): "+A.n(s)+"\n"+A.n(r))
A.aq()
return!1}},
kW(a){var s,r,q,p,o,n,m,l,k,j,i=!1
switch(A.H(a.type)){case"dndenter":case"dndover":case"dndleave":case"dnddrop":i=A.kT(a)
break
case"paint":i=A.l0(a)
break
case"size":i=A.l1(a)
break
case"mousedown":case"mouseup":case"dclick":case"motion":case"enter":case"leave":case"wheel":i=A.l_(a)
break
case"keydown":i=A.kX(a)
break
case"keyup":i=A.kY(a)
break
case"button":i=A.kQ(a)
break
case"menu":A.kZ(A.c(a.id))
break
case"menuopen":i=A.iJ(a,!0)
break
case"menuclose":i=A.iJ(a,!1)
A.hq(a,!1)
break
case"menuhighlight":A.hq(a,!0)
i=!0
break
case"popupdismiss":$.E.j(0,A.c(a.id))
i=!0
break
case"setfocus":case"killfocus":i=A.kU(a)
break
case"popupclose":A.kL()
A.hq(a,!1)
break
case"scroll":s=$.E.j(0,A.c(a.id))
if(s!=null){s=s.id
if(s!=null){r=A.c(a.x)
q=A.c(a.y)
p=s.y1
s.y1=new A.r(r,q)
if(r!==p.a)s.co(4,r,s.rx)
if(q!==p.b)s.co(8,q,s.ry)}}break
case"tool":case"toolenter":case"tooldropdown":i=A.l2(a)
break
case"close":i=A.kR(a)
break
case"infobaraction":o=$.E.j(0,A.c(a.id))
if(o instanceof A.F)o.v(A.eV(200,-1))
i=!0
break
case"gesturepan":case"gesturezoom":n=$.E.j(0,A.c(a.id))
if(n!=null){s=A.H(a.type)
r=n.r
if(s==="gesturepan"){s=$.aJ()
m=new A.dX(s,s)
m.b=260
m.a=r
m.at=new A.r(A.c(a.dx),A.c(a.dy))
l=m}else{k=new A.e7($.aJ())
k.b=261
k.a=r
A.ac(a.zoom)
l=k}l.f=new A.r(A.c(a.x),A.c(a.y))
A.K(a.start)
A.K(a.end)
A.H(a.type)}break
case"frameback":j=$.E.j(0,A.c(a.id))
if(j instanceof A.F){j.c4(!0)
if(!j.ch&&!j.ax){s=v.G.wxc
r=j.d
r===$&&A.b()
s.frameHistory(r,!0)}}i=!0
break
case"drawermenu":$.E.j(0,A.c(a.id))
break
case"drawer":$.E.j(0,A.c(a.id))
i=!0
break
case"text":case"checkbox":case"choice":case"slider":case"hyperlink":case"htmllink":case"htmlloaded":case"htmlerror":case"listbox":case"listboxdclick":case"booksel":case"bookexpand":case"toggle":case"radio":case"radiobox":case"spin":case"search":case"searchcancel":case"combo":case"collapsible":i=A.kS(a)
break
case"imageload":A.ii(A.c(a.id),A.c(a.w),A.c(a.h),!0)
break
case"imageerror":A.ii(A.c(a.id),0,0,!1)
break
default:break}if(A.H(a.type)!=="paint")A.aq()
return i},
kU(a){var s,r,q,p=$.E.j(0,A.c(a.id))
if(p==null)return!1
s=A.H(a.type)==="setfocus"?106:107
r=p.r
q=new A.dI()
q.b=s
q.a=r
return p.v(q)},
l2(a){var s=$.E.j(0,A.c(a.id))
if(!(s instanceof A.bG))return!1
return s.dV(A.H(a.type),A.c(a.x),A.c(a.w),A.c(a.y))},
kS(a){var s,r,q=$.E.j(0,A.c(a.id))
if(q==null)return!1
switch(A.H(a.type)){case"text":return!1
case"toggle":return!0
case"radio":return!0
case"radiobox":return!0
case"spin":return!1
case"search":return!0
case"searchcancel":return!0
case"combo":return!0
case"collapsible":return!0
case"checkbox":return!1
case"choice":return!1
case"slider":return!1
case"hyperlink":if(q instanceof A.cB){q.O=!0
q.a6()
s=q.r
r=new A.dO()
r.b=240
r.a=s
r.e=65e3
if(!q.v(r)){s=q.t
v.G.wxc.openUrl(s)}}return!0
case"htmllink":return!0
case"listbox":return!1
case"listboxdclick":return!1
case"booksel":return!0
case"bookexpand":return!0
case"htmlloaded":case"htmlerror":return!1
default:return!1}},
l0(a){var s,r,q,p=$.E.j(0,A.c(a.id))
if(p==null)return!1
p.cx=A.hn(v.G.wxc.paintContext(A.c(a.id)))
try{r=p.r
q=new A.aV()
q.b=111
q.a=r
s=q
q=p.v(s)
return q}finally{p.cx=null}},
l1(a){var s=$.E.j(0,A.c(a.id))
if(!(s instanceof A.F))return!1
s.dU(A.c(a.w),A.c(a.h))
return!0},
l_(a){var s,r,q=$.E.j(0,A.c(a.id))
if(q==null)return!1
switch(A.H(a.type)){case"mousedown":if(A.c(a.button)===2)s=131
else s=A.c(a.button)===1?132:130
break
case"mouseup":if(A.c(a.button)===2)s=134
else s=A.c(a.button)===1?135:133
break
case"dclick":if(A.c(a.button)===2)s=137
else s=A.c(a.button)===1?138:136
break
case"enter":s=140
break
case"leave":s=141
break
case"wheel":s=142
break
default:s=139}r=new A.dS()
r.b=s
r.a=-1
A.c(v.G.wxc.modifiers())
r.a=q.r
A.c(a.x)
A.c(a.y)
A.K(a.leftDown)
A.K(a.middleDown)
A.K(a.rightDown)
A.K(a.ctrl)
A.K(a.shift)
A.K(a.alt)
A.K(a.meta)
A.c(a.wheel)
return q.v(r)},
lK(a,b){var s,r
if(b==="NumpadEnter")return 370
switch(a){case"ArrowUp":return 315
case"ArrowDown":return 317
case"ArrowLeft":return 314
case"ArrowRight":return 316
case"Enter":return 13
case"Escape":return 27
case"Backspace":return 8
case"Tab":return 9
case"Delete":return 127
case"Insert":return 322
case"Home":return 313
case"End":return 312
case"PageUp":return 366
case"PageDown":return 367
case"Shift":return 306
case"Control":return 308
case"Alt":return 307
case"Meta":return 393
case" ":return 32
default:break}s=a.length
if(s>1&&B.f.bT(a,"F")){r=A.jZ(B.f.b_(a,1),null)
if(r!=null&&r>=1&&r<=24)return 340+r-1}if(s===1){s=a.toUpperCase()
if(0>=s.length)return A.l(s,0)
return s.charCodeAt(0)}return 0},
lG(a){var s
if(a==="Enter")return 13
if(a==="Escape")return 27
if(a==="Backspace")return 8
if(a==="Tab")return 9
s=new A.dw(a)
if(s.gl(0)===1)return s.gbv(0)
return 0},
fK(a,b,c,d){var s,r=new A.dQ()
r.b=a
r.a=-1
A.c(v.G.wxc.modifiers())
r.a=c.r
s=r.r=A.lG(A.H(b.key))
r.f=d&&s!==0&&!A.K(b.ctrl)&&!A.K(b.alt)?s:A.lK(A.H(b.key),A.H(b.code))
A.K(b.ctrl)
A.K(b.shift)
A.K(b.alt)
A.K(b.meta)
return r},
la(a){var s
for(s=a;s!=null;){if(s instanceof A.F)return s
s=s.f}return null},
kX(a){var s,r,q,p,o=$.E.j(0,A.c(a.id))
if(o==null)return!1
s=A.la(o)
if(s!=null)if(s.v(A.fK(153,a,o,!1)))return!0
r=A.fK(150,a,o,!1)
if(o.v(r))return!0
q=r.f
if(!(q===306||q===308||q===307||q===393)&&q!==0)if(o.v(A.fK(152,a,o,!0)))return!0
if(o.cA(q))return!1
if(s instanceof A.F){p=A.K(a.ctrl)||A.K(a.meta)
return s.dP(q,p,A.K(a.alt),A.K(a.shift))}return!1},
kY(a){var s=$.E.j(0,A.c(a.id))
if(s==null)return!1
return s.v(A.fK(151,a,s,!1))},
kQ(a){$.E.j(0,A.c(a.id))
return!1},
l4(a){var s,r,q
for(s=$.aI.length,r=0;r<s;++r)q=$.aI[r]
return null},
kZ(a){if(A.l4(a)==null)return!1
return null.f2(a).eY()},
iJ(a,b){if(!($.E.j(0,A.c(a.id)) instanceof A.F))return!1
return!1},
kR(a){var s=$.E.j(0,A.c(a.id))
if(!(s instanceof A.F))return!1
return!s.c4(A.K(a.canVeto))},
hq(a,b){var s=$.E.j(0,A.c(a.id))
if(!(s instanceof A.F))return
if(b)s.dW(A.c(a.x))},
ad(a){var s=a.d
if(s===255)return"rgb("+a.a+","+a.b+","+a.c+")"
return"rgba("+a.a+","+a.b+","+a.c+","+B.b.an(s/255,3)+")"},
lL(a){var s,r,q,p,o=new A.Y("")
for(s=a.length,r=0;r<s;++r){q=a[r]
if(q==="&"){p=r+1
if(p<s&&a[p]==="&"){o.a+="&"
r=p}continue}o.a+=q}s=o.a
return s.charCodeAt(0)==0?s:s},
h3(a,b,c,d,e){var s=0,r=A.bP(t.S),q,p
var $async$h3=A.bT(function(f,g){if(f===1)return A.bM(g,r)
for(;;)switch(s){case 0:case 3:p=A
s=8
return A.aG(A.m6(A.ai(v.G.wxc,"exportDocument",[c,b,e,d,0,!1],t.m),t.i),$async$h3)
case 8:switch(p.c(g)){case 0:s=5
break
case 1:s=6
break
default:s=7
break}break
case 5:q=5100
s=1
break
case 6:q=5101
s=1
break
case 7:q=-1
s=1
break
case 4:case 1:return A.bN(q,r)}})
return A.bO($async$h3,r)},
ar(a,b,c){var s=v.G.wxc
s.consoleLog(a,b+c)},
ii(a,b,c,d){var s,r,q,p,o,n,m,l=$.hp.j(0,a)
if(l==null)return
l.y=d
s=!d
l.z=s
l.Q=b
l.as=c
if(s)A.ar("error","[error]: ","Could not load bitmap "+a)
for(s=l.x,r=s.length,q=v.G,p=0;p<s.length;s.length===r||(0,A.u)(s),++p){o=s[p]
if(!o.ch)if(o.CW){n=q.wxc
m=o.d
m===$&&A.b()
n.refresh(m)}}B.a.G(s)
s=l.w
if((s.a.a&30)===0)s.a4(l)},
kN(a){var s=$.bK.a5().f
s===$&&A.b()
return s},
lJ(){var s,r,q,p
B.a.eH($.cX,new A.fP())
s=$.cX.length
if(s===0)return
for(r=0;r<$.cX.length;$.cX.length===s||(0,A.u)($.cX),++r)$.cX[r].cl()
s=A.a1(new A.ce($.E,A.ae($.E).h("ce<2>")),t.h)
q=s.length
r=0
for(;r<s.length;s.length===q||(0,A.u)(s),++r){p=s[r]
if(p.ch)continue
if(p instanceof A.bG){p.H=!0
A.aq()}else if(p instanceof A.cD)p.a6()}},
hi(a,b,c){var s,r=$.aK(),q=new A.cw(r),p=new A.aF(new A.C($.y,t.hg),t.h5)
r=new A.a8(r,p,A.d([],t.e))
s=$.iQ
$.iQ=s+1
r.r=s
$.hp.n(0,s,r)
r.a=a
r.b=b
r.c=c
r.cl()
p.a4(r)
q.a=r
q.b=b
return q},
io(a){var s=new A.dW($.jp(),$.hM(),$.cY(),$.bp()),r=a.cx,q=r==null
if(q)A.ar("error","[error]: ","WxPaintDC can only be created in a paint event handler.")
s.as=r
s.dy=A.ac(v.G.wxc.dpr())
if(!q){r.textBaseline="alphabetic"
s.dB()}s.CW=a.d3()
s.cx=a.d1()
s.a=a.dx
return s},
ah(a,b,c,d){var s=new A.dJ()
s.a=a
s.b=b
s.c=c
s.d=d
return s},
iu(){return new A.eb(1,0,0,1,0,0)},
kT(a){if($.E.j(0,A.c(a.id))==null)return!1
return!1},
k8(a){var s=new A.b8(A.d([],t.J),$.aJ(),$.aK())
s.f=a
return s},
aC(a,b){var s=new A.ap(B.q,0,0,0,null,null,$.aK(),new A.G(0,0,0,0))
s.a=B.C
s.r=new A.o(a,b)
return s},
e2(a,b,c,d){var s=new A.ap(B.q,b,c,d,a,null,$.aK(),new A.G(0,0,0,0))
s.a=B.ay
return s},
Z(a,b,c,d){var s=new A.ap(B.q,b,c,d,null,a,$.aK(),new A.G(0,0,0,0))
s.a=B.az
return s},
l3(){var s,r,q,p
if($.bR.a===0)return
s=A.a1($.bR,$.bR.$ti.c)
$.bR.G(0)
B.a.de(s,new A.fJ())
for(r=s.length,q=0;q<s.length;s.length===r||(0,A.u)(s),++q){p=s[q]
if(!p.ch)p.bz()}},
kL(){var s=$.iT
$.iT=$.kM=null
if(s!=null&&(s.a.a&30)===0)s.a4(!0)},
J:function J(a,b){this.a=a
this.b=b},
j:function j(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
eU:function eU(){},
o:function o(a,b){this.a=a
this.b=b},
r:function r(a,b){this.a=a
this.b=b},
G:function G(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
dU:function dU(){},
dV:function dV(a,b){var _=this
_.a=a
_.b=0
_.c=!1
_.d=b},
f3:function f3(){},
fG:function fG(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=c},
eh:function eh(){},
fL:function fL(){},
ei:function ei(a,b,c,d,e){var _=this
_.a=!1
_.b=a
_.c=1
_.d=100
_.e=130
_.f=121
_.r=null
_.w=!1
_.x=b
_.y=c
_.z=d
_.Q=e
_.as=0},
ba:function ba(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,a0,a1,a2,a3){var _=this
_.ay=a
_.ch=b
_.cy=c
_.dx=_.db=!1
_.fx=_.fr=_.dy=0
_.fy=d
_.go=e
_.id=f
_.k1=g
_.k2=h
_.k3=i
_.ok=!1
_.p2=_.p1=0
_.p3=j
_.p4=k
_.R8=l
_.RG=m
_.rx=!1
_.ry=n
_.to=o
_.x1=p
_.xr=_.x2=null
_.d=q
_.e=r
_.f=s
_.r=a0
_.w=a1
_.x=null
_.y=a2
_.z="source-over"
_.Q=!1
_.as=a3},
f0:function f0(a){this.a=a},
f1:function f1(a,b){this.a=a
this.b=b},
f2:function f2(){},
eZ:function eZ(a){this.a=a},
f_:function f_(a){this.a=a},
bE:function bE(a,b){var _=this
_.d=a
_.e=!1
_.x=_.w=0
_.b=b},
W:function W(a,b,c){this.b=a
this.c=b
this.e=c},
eY:function eY(a,b,c){this.a=a
this.b=b
this.c=c},
bb:function bb(a,b,c){this.a=a
this.b=b
this.c=c},
a9:function a9(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
P:function P(){},
dL:function dL(){},
dX:function dX(a,b){var _=this
_.at=a
_.f=b
_.b=_.a=$
_.c=!1
_.e=0},
e7:function e7(a){var _=this
_.f=a
_.b=_.a=$
_.c=!1
_.e=0},
e0:function e0(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
dI:function dI(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
dF:function dF(){var _=this
_.f=!1
_.b=_.a=$
_.c=!1
_.e=0},
cy:function cy(){},
aU:function aU(a,b,c){this.c=a
this.a=b
this.b=c},
cz:function cz(){},
dO:function dO(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
dP:function dP(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
dQ:function dQ(){var _=this
_.r=_.f=0
_.b=_.a=$
_.c=!1
_.e=0},
dR:function dR(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
dS:function dS(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
aV:function aV(){var _=this
_.b=_.a=$
_.c=!1
_.e=0},
e1:function e1(a){var _=this
_.r=a
_.b=_.a=$
_.c=!1
_.e=0},
e6:function e6(){var _=this
_.ax=!1
_.ay=!0
_.b=_.a=$
_.c=!1
_.e=0},
dG:function dG(a,b,c){var _=this
_.f=$
_.a=a
_.b=null
_.c=b
_.d=c},
e_:function e_(a,b,c){var _=this
_.f=$
_.a=a
_.b=null
_.c=b
_.d=c},
Q:function Q(a,b){this.a=a
this.b=b},
dH:function dH(){},
cB:function cB(a,b,c,d,e,f,g,h,i,j,k,l,m){var _=this
_.t=""
_.O=!1
_.H=a
_.eu=b
_.ev=c
_.d=$
_.e=d
_.f=e
_.r=f
_.w=g
_.x=h
_.y=i
_.z=j
_.Q=k
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=l
_.a=m
_.c=null},
cD:function cD(a,b,c,d,e,f,g,h,i,j,k){var _=this
_.t=a
_.d=$
_.e=b
_.f=c
_.r=d
_.w=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=j
_.a=k
_.c=null},
f5:function f5(a,b){this.a=a
this.b=b},
e3:function e3(a,b,c,d,e,f,g,h,i,j){var _=this
_.d=$
_.e=a
_.f=b
_.r=c
_.w=d
_.x=e
_.y=f
_.z=g
_.Q=h
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=i
_.a=j
_.c=null},
e4:function e4(a,b,c,d,e,f,g,h,i,j){var _=this
_.t=-1
_.O=!1
_.d=$
_.e=a
_.f=b
_.r=c
_.w=d
_.x=e
_.y=f
_.z=g
_.Q=h
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=i
_.a=j
_.c=null},
aD:function aD(){var _=this
_.a=-1
_.c=!0
_.d=!1
_.r=0
_.x=_.w=""
_.z=_.y=null},
bG:function bG(a,b,c,d,e,f,g,h,i,j,k){var _=this
_.t=a
_.H=!1
_.d=$
_.e=b
_.f=c
_.r=d
_.w=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=j
_.a=k
_.c=null},
f7:function f7(a,b){this.a=a
this.b=b},
dE:function dE(){},
eT:function eT(){},
i:function i(){},
a8:function a8(a,b,c){var _=this
_.a=null
_.b=a
_.c=null
_.r=$
_.w=b
_.x=c
_.z=_.y=!1
_.as=_.Q=0
_.at=1},
fP:function fP(){},
cw:function cw(a){this.a=$
this.b=null
this.d=a},
f6:function f6(a,b){this.a=a
this.b=b},
dZ:function dZ(){},
cx:function cx(){},
eW:function eW(a){this.a=a},
dW:function dW(a,b,c,d){var _=this
_.as=null
_.ax=a
_.ay=b
_.CW=c
_.cx=d
_.dy=1
_.fy=_.fx=_.fr=null
_.go=-1
_.k2=_.k1=_.id=-100
_.a=null},
dJ:function dJ(){var _=this
_.d=_.c=_.b=_.a=$
_.r=null},
dN:function dN(){},
eb:function eb(a,b,c,d,e,f){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f},
fs:function fs(){var _=this
_.a=!1
_.b="rgba(0,0,0,1)"
_.c=100
_.d=1
_.e=130
_.f=121},
dM:function dM(){},
cA:function cA(){},
e5:function e5(a){var _=this
_.a=$
_.b=null
_.c=1000
_.d=1
_.e=null
_.f=a},
f8:function f8(a){this.a=a},
b8:function b8(a,b,c){var _=this
_.f=$
_.a=a
_.b=null
_.c=b
_.d=c},
eR:function eR(){},
eS:function eS(){},
eQ:function eQ(a,b){this.a=a
this.b=b},
eP:function eP(){},
bF:function bF(a,b){this.a=a
this.b=b},
ap:function ap(a,b,c,d,e,f,g,h){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f
_.r=g
_.y=h},
bc:function bc(){},
dK:function dK(){},
eX:function eX(a){this.a=a},
dY:function dY(a,b,c,d,e,f,g,h,i,j){var _=this
_.d=$
_.e=a
_.f=b
_.r=c
_.w=d
_.x=e
_.y=f
_.z=g
_.Q=h
_.as=!1
_.at=null
_.CW=_.ch=_.ay=_.ax=!1
_.cx=null
_.cy=""
_.id=_.go=_.fy=_.fr=_.dy=_.dx=null
_.k1=i
_.a=j
_.c=null},
cC:function cC(){},
dT:function dT(){},
aE:function aE(){},
fJ:function fJ(){},
B:function B(){},
f9:function f9(a,b){this.a=a
this.b=b},
j9(a){return v.mangledGlobalNames[a]}},B={}
var w=[A,J,B]
var $={}
A.h9.prototype={}
J.d9.prototype={
F(a,b){return a===b},
gp(a){return A.ck(a)},
i(a){return"Instance of '"+A.ds(a)+"'"},
gB(a){return A.bk(A.hs(this))}}
J.c7.prototype={
i(a){return String(a)},
bN(a,b){return b||a},
gp(a){return a?519018:218159},
gB(a){return A.bk(t.v)},
$ix:1,
$iM:1}
J.c9.prototype={
F(a,b){return null==b},
i(a){return"null"},
gp(a){return 0},
$ix:1,
$iN:1}
J.ca.prototype={$iD:1}
J.aO.prototype={
gp(a){return 0},
i(a){return String(a)}}
J.dr.prototype={}
J.bB.prototype={}
J.at.prototype={
i(a){var s=a[$.jb()]
if(s==null)s=a[$.hG()]
if(s==null)return this.dg(a)
return"JavaScript function for "+J.cZ(s)},
$ib2:1}
J.bt.prototype={
gp(a){return 0},
i(a){return String(a)}}
J.bu.prototype={
gp(a){return 0},
i(a){return String(a)}}
J.p.prototype={
k(a,b){A.R(a).c.a(b)
a.$flags&1&&A.aj(a,29)
a.push(b)},
cT(a,b,c){A.R(a).c.a(c)
a.$flags&1&&A.aj(a,"insert",2)
if(b<0||b>a.length)throw A.e(A.i9(b,null))
a.splice(b,0,c)},
a_(a,b){var s
a.$flags&1&&A.aj(a,"remove",1)
for(s=0;s<a.length;++s)if(J.al(a[s],b)){a.splice(s,1)
return!0}return!1},
eH(a,b){A.R(a).h("M(1)").a(b)
a.$flags&1&&A.aj(a,16)
this.e0(a,b,!0)},
e0(a,b,c){var s,r,q,p,o
A.R(a).h("M(1)").a(b)
s=[]
r=a.length
for(q=0;q<r;++q){p=a[q]
if(!b.$1(p))s.push(p)
if(a.length!==r)throw A.e(A.a7(a))}o=s.length
if(o===r)return
this.sl(a,o)
for(q=0;q<s.length;++q)a[q]=s[q]},
G(a){a.$flags&1&&A.aj(a,"clear","clear")
a.length=0},
aW(a,b){return A.ic(a,b,null,A.R(a).c)},
ex(a,b,c,d){var s,r,q
d.a(b)
A.R(a).D(d).h("1(1,2)").a(c)
s=a.length
for(r=b,q=0;q<s;++q){r=c.$2(r,a[q])
if(a.length!==s)throw A.e(A.a7(a))}return r},
L(a,b){if(!(b>=0&&b<a.length))return A.l(a,b)
return a[b]},
gbv(a){if(a.length>0)return a[0]
throw A.e(A.hV())},
eG(a,b,c){a.$flags&1&&A.aj(a,18)
A.du(b,c,a.length)
a.splice(b,c-b)},
ec(a,b){var s,r
A.R(a).h("M(1)").a(b)
s=a.length
for(r=0;r<s;++r){if(b.$1(a[r]))return!0
if(a.length!==s)throw A.e(A.a7(a))}return!1},
de(a,b){var s,r,q,p,o,n=A.R(a)
n.h("a(1,1)?").a(b)
a.$flags&2&&A.aj(a,"sort")
s=a.length
if(s<2)return
if(b==null)b=J.lg()
if(s===2){r=a[0]
q=a[1]
n=b.$2(r,q)
if(typeof n!=="number")return n.eX()
if(n>0){a[0]=q
a[1]=r}return}p=0
if(n.c.b(null))for(o=0;o<a.length;++o)if(a[o]===void 0){a[o]=null;++p}a.sort(A.bj(b,2))
if(p>0)this.e1(a,p)},
e1(a,b){var s,r=a.length
for(;s=r-1,r>0;r=s)if(a[s]===null){a[s]=void 0;--b
if(b===0)break}},
cS(a,b){var s,r=a.length
if(0>=r)return-1
for(s=0;s<r;++s){if(!(s<a.length))return A.l(a,s)
if(J.al(a[s],b))return s}return-1},
gby(a){return a.length!==0},
i(a){return A.h8(a,"[","]")},
gC(a){return new J.c1(a,a.length,A.R(a).h("c1<1>"))},
gp(a){return A.ck(a)},
gl(a){return a.length},
sl(a,b){a.$flags&1&&A.aj(a,"set length","change the length of")
if(b<0)throw A.e(A.ax(b,0,null,"newLength",null))
if(b>a.length)A.R(a).c.a(null)
a.length=b},
j(a,b){if(!(b>=0&&b<a.length))throw A.e(A.fS(a,b))
return a[b]},
n(a,b,c){A.R(a).c.a(c)
a.$flags&2&&A.aj(a)
if(!(b>=0&&b<a.length))throw A.e(A.fS(a,b))
a[b]=c},
$ik:1,
$ih:1,
$im:1}
J.da.prototype={
eS(a){var s,r,q
if(!Array.isArray(a))return null
s=a.$flags|0
if((s&4)!==0)r="const, "
else if((s&2)!==0)r="unmodifiable, "
else r=(s&1)!==0?"fixed, ":""
q="Instance of '"+A.ds(a)+"'"
if(r==="")return q
return q+" ("+r+"length: "+a.length+")"}}
J.er.prototype={}
J.c1.prototype={
gA(){var s=this.d
return s==null?this.$ti.c.a(s):s},
q(){var s,r=this,q=r.a,p=q.length
if(r.b!==p){q=A.u(q)
throw A.e(q)}s=r.c
if(s>=p){r.d=null
return!1}r.d=q[s]
r.c=s+1
return!0},
$iX:1}
J.bs.prototype={
K(a,b){var s
A.ho(b)
if(a<b)return-1
else if(a>b)return 1
else if(a===b){if(a===0){s=this.gaO(b)
if(this.gaO(a)===s)return 0
if(this.gaO(a))return-1
return 1}return 0}else if(isNaN(a)){if(isNaN(b))return 0
return 1}else return-1},
gaO(a){return a===0?1/a<0:a<0},
ag(a){var s,r
if(a>=0){if(a<=2147483647){s=a|0
return a===s?s:s+1}}else if(a>=-2147483648)return a|0
r=Math.ceil(a)
if(isFinite(r))return r
throw A.e(A.aT(""+a+".ceil()"))},
aL(a){var s,r
if(a>=0){if(a<=2147483647)return a|0}else if(a>=-2147483648){s=a|0
return a===s?s:s-1}r=Math.floor(a)
if(isFinite(r))return r
throw A.e(A.aT(""+a+".floor()"))},
u(a){if(a>0){if(a!==1/0)return Math.round(a)}else if(a>-1/0)return 0-Math.round(0-a)
throw A.e(A.aT(""+a+".round()"))},
aG(a,b,c){if(B.c.K(b,c)>0)throw A.e(A.j0(b))
if(this.K(a,b)<0)return b
if(this.K(a,c)>0)return c
return a},
an(a,b){var s
if(b>20)throw A.e(A.ax(b,0,20,"fractionDigits",null))
s=a.toFixed(b)
if(a===0&&this.gaO(a))return"-"+s
return s},
cX(a,b){var s,r,q,p,o
if(b<2||b>36)throw A.e(A.ax(b,2,36,"radix",null))
s=a.toString(b)
r=s.length
q=r-1
if(!(q>=0))return A.l(s,q)
if(s.charCodeAt(q)!==41)return s
p=/^([\da-z]+)(?:\.([\da-z]+))?\(e\+(\d+)\)$/.exec(s)
if(p==null)A.h2(A.aT("Unexpected toString result: "+s))
r=p.length
if(1>=r)return A.l(p,1)
s=p[1]
if(3>=r)return A.l(p,3)
o=+p[3]
r=p[2]
if(r!=null){s+=r
o-=r.length}return s+B.f.bM("0",o)},
i(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
gp(a){var s,r,q,p,o=a|0
if(a===o)return o&536870911
s=Math.abs(a)
r=Math.log(s)/0.6931471805599453|0
q=Math.pow(2,r)
p=s<1?s/q:q/s
return((p*9007199254740992|0)+(p*3542243181176521|0))*599197+r*1259&536870911},
bL(a,b){var s=a%b
if(s===0)return 0
if(s>0)return s
return s+b},
a9(a,b){if((a|0)===a)if(b>=1||b<-1)return a/b|0
return this.cu(a,b)},
J(a,b){return(a|0)===a?a/b|0:this.cu(a,b)},
cu(a,b){var s=a/b
if(s>=-2147483648&&s<=2147483647)return s|0
if(s>0){if(s!==1/0)return Math.floor(s)}else if(s>-1/0)return Math.ceil(s)
throw A.e(A.aT("Result of truncating division is "+A.n(s)+": "+A.n(a)+" ~/ "+b))},
ct(a,b){var s
if(a>0)s=this.e5(a,b)
else{s=b>31?31:b
s=a>>s>>>0}return s},
e5(a,b){return b>31?0:a>>>b},
gB(a){return A.bk(t.o)},
$ia_:1,
$if:1,
$iS:1}
J.c8.prototype={
gB(a){return A.bk(t.S)},
$ix:1,
$ia:1}
J.db.prototype={
gB(a){return A.bk(t.i)},
$ix:1}
J.b3.prototype={
cL(a,b){var s=b.length,r=a.length
if(s>r)return!1
return b===this.b_(a,r-s)},
bT(a,b){var s=b.length
if(s>a.length)return!1
return b===a.substring(0,s)},
a0(a,b,c){return a.substring(b,A.du(b,c,a.length))},
b_(a,b){return this.a0(a,b,null)},
bM(a,b){var s,r
if(0>=b)return""
if(b===1||a.length===0)return a
if(b!==b>>>0)throw A.e(B.L)
for(s=a,r="";;){if((b&1)===1)r=s+r
b=b>>>1
if(b===0)break
s+=s}return r},
al(a,b,c){var s=b-a.length
if(s<=0)return a
return this.bM(c,s)+a},
K(a,b){var s
A.H(b)
if(a===b)s=0
else s=a<b?-1:1
return s},
i(a){return a},
gp(a){var s,r,q
for(s=a.length,r=0,q=0;q<s;++q){r=r+a.charCodeAt(q)&536870911
r=r+((r&524287)<<10)&536870911
r^=r>>6}r=r+((r&67108863)<<3)&536870911
r^=r>>11
return r+((r&16383)<<15)&536870911},
gB(a){return A.bk(t.N)},
gl(a){return a.length},
$ix:1,
$ia_:1,
$ii_:1,
$iz:1}
A.bv.prototype={
i(a){return"LateInitializationError: "+this.a}}
A.c2.prototype={
gl(a){return this.a.length},
j(a,b){var s=this.a
if(!(b>=0&&b<s.length))return A.l(s,b)
return s.charCodeAt(b)}}
A.eK.prototype={}
A.k.prototype={}
A.ao.prototype={
gC(a){var s=this
return new A.av(s,s.gl(s),A.ae(s).h("av<ao.E>"))},
gP(a){return this.gl(this)===0},
cU(a,b){var s,r,q,p=this,o=p.gl(p)
if(b.length!==0){if(o===0)return""
s=A.n(p.L(0,0))
if(o!==p.gl(p))throw A.e(A.a7(p))
for(r=s,q=1;q<o;++q){r=r+b+A.n(p.L(0,q))
if(o!==p.gl(p))throw A.e(A.a7(p))}return r.charCodeAt(0)==0?r:r}else{for(q=0,r="";q<o;++q){r+=A.n(p.L(0,q))
if(o!==p.gl(p))throw A.e(A.a7(p))}return r.charCodeAt(0)==0?r:r}}}
A.cs.prototype={
gdL(){var s=J.c0(this.a)
return s},
ge6(){var s=J.c0(this.a),r=this.b
if(r>s)return s
return r},
gl(a){var s=J.c0(this.a),r=this.b
if(r>=s)return 0
return s-r},
L(a,b){var s=this,r=s.ge6()+b
if(b<0||r>=s.gdL())throw A.e(A.h7(b,s.gl(0),s,"index"))
return J.hN(s.a,r)},
cW(a,b){var s,r,q=this,p=q.b,o=q.a,n=J.ek(o),m=n.gl(o),l=m-p
if(l<=0){o=J.hW(0,q.$ti.c)
return o}s=A.hd(l,n.L(o,p),!1,q.$ti.c)
for(r=1;r<l;++r){B.a.n(s,r,n.L(o,p+r))
if(n.gl(o)<m)throw A.e(A.a7(q))}return s}}
A.av.prototype={
gA(){var s=this.d
return s==null?this.$ti.c.a(s):s},
q(){var s,r=this,q=r.a,p=J.ek(q),o=p.gl(q)
if(r.b!==o)throw A.e(A.a7(q))
s=r.c
if(s>=o){r.d=null
return!1}r.d=p.L(q,s);++r.c
return!0},
$iX:1}
A.aw.prototype={
gl(a){return J.c0(this.a)},
L(a,b){return this.b.$1(J.hN(this.a,b))}}
A.aB.prototype={
gC(a){return new A.cv(J.h5(this.a),this.b,this.$ti.h("cv<1>"))}}
A.cv.prototype={
q(){var s,r
for(s=this.a,r=this.b;s.q();)if(r.$1(s.gA()))return!0
return!1},
gA(){return this.a.gA()},
$iX:1}
A.b6.prototype={
gC(a){var s=this.a
return new A.cp(s.gC(s),this.b,A.ae(this).h("cp<1>"))}}
A.c4.prototype={
gl(a){var s=this.a,r=s.gl(s)-this.b
if(r>=0)return r
return 0},
$ik:1}
A.cp.prototype={
q(){var s,r
for(s=this.a,r=0;r<this.b;++r)s.q()
this.b=0
return s.q()},
gA(){return this.a.gA()},
$iX:1}
A.V.prototype={}
A.b7.prototype={
n(a,b,c){A.ae(this).h("b7.E").a(c)
throw A.e(A.aT("Cannot modify an unmodifiable list"))}}
A.bC.prototype={}
A.cL.prototype={$r:"+panel,sizer(1,2)",$s:1}
A.bh.prototype={$r:"+dish,height,title(1,2,3)",$s:2}
A.aX.prototype={$r:"+(1,2,3,4)",$s:3}
A.br.prototype={
gP(a){return this.gl(this)===0},
i(a){return A.he(this)},
$iaP:1}
A.c3.prototype={
gl(a){return this.b.length},
gdS(){var s=this.$keys
if(s==null){s=Object.keys(this.a)
this.$keys=s}return s},
br(a){if(typeof a!="string")return!1
if("__proto__"===a)return!1
return this.a.hasOwnProperty(a)},
j(a,b){if(!this.br(b))return null
return this.b[this.a[b]]},
Z(a,b){var s,r,q,p
this.$ti.h("~(1,2)").a(b)
s=this.gdS()
r=this.b
for(q=s.length,p=0;p<q;++p)b.$2(s[p],r[p])}}
A.c6.prototype={
ba(){var s=this,r=s.$map
if(r==null){r=new A.cb(s.$ti.h("cb<1,2>"))
A.j3(s.a,r)
s.$map=r}return r},
j(a,b){return this.ba().j(0,b)},
Z(a,b){this.$ti.h("~(1,2)").a(b)
this.ba().Z(0,b)},
gl(a){return this.ba().a}}
A.eB.prototype={
$0(){return B.b.aL(1000*this.a.now())},
$S:11}
A.co.prototype={}
A.eN.prototype={
R(a){var s,r,q=this,p=new RegExp(q.a).exec(a)
if(p==null)return null
s=Object.create(null)
r=q.b
if(r!==-1)s.arguments=p[r+1]
r=q.c
if(r!==-1)s.argumentsExpr=p[r+1]
r=q.d
if(r!==-1)s.expr=p[r+1]
r=q.e
if(r!==-1)s.method=p[r+1]
r=q.f
if(r!==-1)s.receiver=p[r+1]
return s}}
A.cj.prototype={
i(a){return"Null check operator used on a null value"}}
A.dc.prototype={
i(a){var s,r=this,q="NoSuchMethodError: method not found: '",p=r.b
if(p==null)return"NoSuchMethodError: "+r.a
s=r.c
if(s==null)return q+p+"' ("+r.a+")"
return q+p+"' on '"+s+"' ("+r.a+")"}}
A.dD.prototype={
i(a){var s=this.a
return s.length===0?"Error":"Error: "+s}}
A.eA.prototype={
i(a){return"Throw of null ('"+(this.a===null?"null":"undefined")+"' from JavaScript)"}}
A.c5.prototype={}
A.cN.prototype={
i(a){var s,r=this.b
if(r!=null)return r
r=this.a
s=r!==null&&typeof r==="object"?r.stack:null
return this.b=s==null?"":s},
$iaS:1}
A.aL.prototype={
i(a){var s=this.constructor,r=s==null?null:s.name
return"Closure '"+A.ja(r==null?"unknown":r)+"'"},
$ib2:1,
geW(){return this},
$C:"$1",
$R:1,
$D:null}
A.d1.prototype={$C:"$0",$R:0}
A.d2.prototype={$C:"$2",$R:2}
A.dA.prototype={}
A.dz.prototype={
i(a){var s=this.$static_name
if(s==null)return"Closure of unknown static method"
return"Closure '"+A.ja(s)+"'"}}
A.bq.prototype={
F(a,b){if(b==null)return!1
if(this===b)return!0
if(!(b instanceof A.bq))return!1
return this.$_target===b.$_target&&this.a===b.a},
gp(a){return(A.hE(this.a)^A.ck(this.$_target))>>>0},
i(a){return"Closure '"+this.$_name+"' of "+("Instance of '"+A.ds(this.a)+"'")}}
A.dx.prototype={
i(a){return"RuntimeError: "+this.a}}
A.au.prototype={
gl(a){return this.a},
gP(a){return this.a===0},
br(a){var s
if((a&0x3fffffff)===a){s=this.c
if(s==null)return!1
return s[a]!=null}else return this.ez(a)},
ez(a){var s=this.d
if(s==null)return!1
return this.ai(this.c8(s,a),a)>=0},
j(a,b){var s,r,q,p,o=null
if(typeof b=="string"){s=this.b
if(s==null)return o
r=s[b]
q=r==null?o:r.b
return q}else if(typeof b=="number"&&(b&0x3fffffff)===b){p=this.c
if(p==null)return o
r=p[b]
q=r==null?o:r.b
return q}else return this.eA(b)},
eA(a){var s,r,q=this.d
if(q==null)return null
s=this.c8(q,a)
r=this.ai(s,a)
if(r<0)return null
return s[r].b},
n(a,b,c){var s,r,q,p,o,n,m=this,l=A.ae(m)
l.c.a(b)
l.y[1].a(c)
if(typeof b=="string"){s=m.b
m.bU(s==null?m.b=m.bd():s,b,c)}else if(typeof b=="number"&&(b&0x3fffffff)===b){r=m.c
m.bU(r==null?m.c=m.bd():r,b,c)}else{q=m.d
if(q==null)q=m.d=m.bd()
p=m.aN(b)
o=q[p]
if(o==null)q[p]=[m.b0(b,c)]
else{n=m.ai(o,b)
if(n>=0)o[n].b=c
else o.push(m.b0(b,c))}}},
a_(a,b){if((b&0x3fffffff)===b)return this.dw(this.c,b)
else return this.eB(b)},
eB(a){var s,r,q,p,o=this,n=o.d
if(n==null)return null
s=o.aN(a)
r=n[s]
q=o.ai(r,a)
if(q<0)return null
p=r.splice(q,1)[0]
o.bW(p)
if(r.length===0)delete n[s]
return p.b},
Z(a,b){var s,r,q=this
A.ae(q).h("~(1,2)").a(b)
s=q.e
r=q.r
while(s!=null){b.$2(s.a,s.b)
if(r!==q.r)throw A.e(A.a7(q))
s=s.c}},
bU(a,b,c){var s,r=A.ae(this)
r.c.a(b)
r.y[1].a(c)
s=a[b]
if(s==null)a[b]=this.b0(b,c)
else s.b=c},
dw(a,b){var s
if(a==null)return null
s=a[b]
if(s==null)return null
this.bW(s)
delete a[b]
return s.b},
bV(){this.r=this.r+1&1073741823},
b0(a,b){var s=this,r=A.ae(s),q=new A.eu(r.c.a(a),r.y[1].a(b))
if(s.e==null)s.e=s.f=q
else{r=s.f
r.toString
q.d=r
s.f=r.c=q}++s.a
s.bV()
return q},
bW(a){var s=this,r=a.d,q=a.c
if(r==null)s.e=q
else r.c=q
if(q==null)s.f=r
else q.d=r;--s.a
s.bV()},
aN(a){return J.af(a)&1073741823},
c8(a,b){return a[this.aN(b)]},
ai(a,b){var s,r
if(a==null)return-1
s=a.length
for(r=0;r<s;++r)if(J.al(a[r].a,b))return r
return-1},
i(a){return A.he(this)},
bd(){var s=Object.create(null)
s["<non-identifier-key>"]=s
delete s["<non-identifier-key>"]
return s},
$ihb:1}
A.eu.prototype={}
A.ev.prototype={
gl(a){return this.a.a},
gP(a){return this.a.a===0},
gC(a){var s=this.a
return new A.b4(s,s.r,s.e,this.$ti.h("b4<1>"))}}
A.b4.prototype={
gA(){return this.d},
q(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.e(A.a7(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=s.a
r.c=s.c
return!0}},
$iX:1}
A.ce.prototype={
gl(a){return this.a.a},
gP(a){return this.a.a===0},
gC(a){var s=this.a
return new A.cd(s,s.r,s.e,this.$ti.h("cd<1>"))}}
A.cd.prototype={
gA(){return this.d},
q(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.e(A.a7(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=s.b
r.c=s.c
return!0}},
$iX:1}
A.cb.prototype={
aN(a){return A.lP(a)&1073741823},
ai(a,b){var s,r
if(a==null)return-1
s=a.length
for(r=0;r<s;++r)if(J.al(a[r].a,b))return r
return-1}}
A.fW.prototype={
$1(a){return this.a(a)},
$S:7}
A.fX.prototype={
$2(a,b){return this.a(a,b)},
$S:23}
A.fY.prototype={
$1(a){return this.a(A.H(a))},
$S:37}
A.aa.prototype={
i(a){return this.cw(!1)},
cw(a){var s,r,q,p,o,n=this.dN(),m=this.aA(),l=(a?"Record ":"")+"("
for(s=n.length,r="",q=0;q<s;++q,r=", "){l+=r
p=n[q]
if(typeof p=="string")l=l+p+": "
if(!(q<m.length))return A.l(m,q)
o=m[q]
l=a?l+A.i7(o):l+A.n(o)}l+=")"
return l.charCodeAt(0)==0?l:l},
dN(){var s,r=this.$s
while($.fx.length<=r)B.a.k($.fx,null)
s=$.fx[r]
if(s==null){s=this.dJ()
B.a.n($.fx,r,s)}return s},
dJ(){var s,r,q,p=this.$r,o=p.indexOf("("),n=p.substring(1,o),m=p.substring(o),l=m==="()"?0:m.replace(/[^,]/g,"").length+1,k=A.d(new Array(l),t.f)
for(s=0;s<l;++s)k[s]=s
if(n!==""){r=n.split(",")
s=r.length
for(q=l;s>0;){--q;--s
B.a.n(k,q,r[s])}}k=A.jR(k,!1,t.K)
k.$flags=3
return k}}
A.bH.prototype={
aA(){return[this.a,this.b]},
F(a,b){if(b==null)return!1
return b instanceof A.bH&&this.$s===b.$s&&J.al(this.a,b.a)&&J.al(this.b,b.b)},
gp(a){return A.dp(this.$s,this.a,this.b,B.i)}}
A.bI.prototype={
aA(){return[this.a,this.b,this.c]},
F(a,b){var s=this
if(b==null)return!1
return b instanceof A.bI&&s.$s===b.$s&&J.al(s.a,b.a)&&J.al(s.b,b.b)&&J.al(s.c,b.c)},
gp(a){var s=this
return A.dp(s.$s,s.a,s.b,s.c)}}
A.bJ.prototype={
aA(){return this.a},
F(a,b){if(b==null)return!1
return b instanceof A.bJ&&this.$s===b.$s&&A.ks(this.a,b.a)},
gp(a){return A.dp(this.$s,A.jU(this.a),B.i,B.i)}}
A.fe.prototype={
a5(){var s=this.b
if(s===this)throw A.e(A.hY(""))
return s}}
A.b5.prototype={
gB(a){return B.a3},
cE(a,b,c){var s=new Uint8Array(a,b,c)
return s},
$ix:1,
$ib5:1}
A.cg.prototype={
geg(a){if(((a.$flags|0)&2)!==0)return new A.fE(a.buffer)
else return a.buffer},
dR(a,b,c,d){var s=A.ax(b,0,c,d,null)
throw A.e(s)},
c1(a,b,c,d){if(b>>>0!==b||b>c)this.dR(a,b,c,d)}}
A.fE.prototype={
cE(a,b,c){var s=A.jT(this.a,b,c)
s.$flags=3
return s}}
A.dg.prototype={
gB(a){return B.a4},
$ix:1}
A.T.prototype={
gl(a){return a.length},
e4(a,b,c,d,e){var s,r,q=a.length
this.c1(a,b,q,"start")
this.c1(a,c,q,"end")
if(b>c)throw A.e(A.ax(b,0,c,null,null))
s=c-b
r=d.length
if(r-e<s)throw A.e(A.dy("Not enough elements"))
if(e!==0||r!==s)d=d.subarray(e,e+s)
a.set(d,b)},
$ia0:1}
A.cf.prototype={
j(a,b){A.aH(b,a,a.length)
return a[b]},
n(a,b,c){A.ac(c)
a.$flags&2&&A.aj(a)
A.aH(b,a,a.length)
a[b]=c},
$ik:1,
$ih:1,
$im:1}
A.a2.prototype={
n(a,b,c){A.c(c)
a.$flags&2&&A.aj(a)
A.aH(b,a,a.length)
a[b]=c},
aV(a,b,c,d,e){t.Y.a(d)
a.$flags&2&&A.aj(a,5)
if(t.E.b(d)){this.e4(a,b,c,d,e)
return}this.dh(a,b,c,d,e)},
bQ(a,b,c,d){return this.aV(a,b,c,d,0)},
$ik:1,
$ih:1,
$im:1}
A.dh.prototype={
gB(a){return B.a5},
$ix:1}
A.di.prototype={
gB(a){return B.a6},
$ix:1}
A.dj.prototype={
gB(a){return B.a7},
j(a,b){A.aH(b,a,a.length)
return a[b]},
$ix:1}
A.dk.prototype={
gB(a){return B.a8},
j(a,b){A.aH(b,a,a.length)
return a[b]},
$ix:1}
A.dl.prototype={
gB(a){return B.a9},
j(a,b){A.aH(b,a,a.length)
return a[b]},
$ix:1}
A.dm.prototype={
gB(a){return B.ab},
j(a,b){A.aH(b,a,a.length)
return a[b]},
$ix:1}
A.dn.prototype={
gB(a){return B.ac},
j(a,b){A.aH(b,a,a.length)
return a[b]},
$ix:1}
A.ch.prototype={
gB(a){return B.ad},
gl(a){return a.length},
j(a,b){A.aH(b,a,a.length)
return a[b]},
$ix:1}
A.ci.prototype={
gB(a){return B.ae},
gl(a){return a.length},
j(a,b){A.aH(b,a,a.length)
return a[b]},
$ix:1,
$ict:1}
A.cH.prototype={}
A.cI.prototype={}
A.cJ.prototype={}
A.cK.prototype={}
A.ag.prototype={
h(a){return A.cT(v.typeUniverse,this,a)},
D(a){return A.iE(v.typeUniverse,this,a)}}
A.ea.prototype={}
A.eg.prototype={
i(a){return A.a4(this.a,null)}}
A.e9.prototype={
i(a){return this.a}}
A.cP.prototype={$iaz:1}
A.fb.prototype={
$1(a){var s=this.a,r=s.a
s.a=null
r.$0()},
$S:5}
A.fa.prototype={
$1(a){var s,r
this.a.a=t.M.a(a)
s=this.b
r=this.c
s.firstChild?s.removeChild(r):s.appendChild(r)},
$S:30}
A.fc.prototype={
$0(){this.a.$0()},
$S:2}
A.fd.prototype={
$0(){this.a.$0()},
$S:2}
A.cO.prototype={
du(a,b){if(self.setTimeout!=null)this.b=self.setTimeout(A.bj(new A.fB(this,b),0),a)
else throw A.e(A.aT("`setTimeout()` not found."))},
dv(a,b){if(self.setTimeout!=null)this.b=self.setInterval(A.bj(new A.fA(this,a,Date.now(),b),0),a)
else throw A.e(A.aT("Periodic timer."))},
eh(){if(self.setTimeout!=null){var s=this.b
if(s==null)return
if(this.a)self.clearTimeout(s)
else self.clearInterval(s)
this.b=null}else throw A.e(A.aT("Canceling a timer."))},
$idB:1}
A.fB.prototype={
$0(){var s=this.a
s.b=null
s.c=1
this.b.$0()},
$S:0}
A.fA.prototype={
$0(){var s,r=this,q=r.a,p=q.c+1,o=r.b
if(o>0){s=Date.now()-r.c
if(s>(p+1)*o)p=B.c.a9(s,o)}q.c=p
r.d.$1(q)},
$S:2}
A.cE.prototype={
a4(a){var s,r=this,q=r.$ti
q.h("1/?").a(a)
if(a==null)a=q.c.a(a)
if(!r.b)r.a.bZ(a)
else{s=r.a
if(q.h("an<1>").b(a))s.c0(a)
else s.c2(a)}},
bq(a,b){var s=this.a
if(this.b)s.b7(new A.a6(a,b))
else s.b3(new A.a6(a,b))},
$iep:1}
A.fH.prototype={
$1(a){return this.a.$2(0,a)},
$S:3}
A.fI.prototype={
$2(a,b){this.a.$2(1,new A.c5(a,t.l.a(b)))},
$S:22}
A.fQ.prototype={
$2(a,b){this.a(A.c(a),b)},
$S:19}
A.a6.prototype={
i(a){return A.n(this.a)},
$iA:1,
ga8(){return this.b}}
A.eq.prototype={
$0(){this.c.a(null)
this.b.dH(null)},
$S:0}
A.cF.prototype={
bq(a,b){var s=this.a
if((s.a&30)!==0)throw A.e(A.dy("Future already completed"))
s.b3(A.lf(a,b))},
cI(a){return this.bq(a,null)},
$iep:1}
A.aF.prototype={
a4(a){var s,r=this.$ti
r.h("1/?").a(a)
s=this.a
if((s.a&30)!==0)throw A.e(A.dy("Future already completed"))
s.bZ(r.h("1/").a(a))}}
A.bd.prototype={
eC(a){if((this.c&15)!==6)return!0
return this.b.b.bF(t.al.a(this.d),a.a,t.v,t.K)},
ey(a){var s,r=this,q=r.e,p=null,o=t.z,n=t.K,m=a.a,l=r.b.b
if(t.Q.b(q))p=l.eM(q,m,a.b,o,n,t.l)
else p=l.bF(t.w.a(q),m,o,n)
try{o=r.$ti.h("2/").a(p)
return o}catch(s){if(t.eK.b(A.b0(s))){if((r.c&1)!==0)throw A.e(A.en("The error handler of Future.then must return a value of the returned future's type","onError"))
throw A.e(A.en("The error handler of Future.catchError must return a value of the future's type","onError"))}else throw s}}}
A.C.prototype={
bG(a,b,c){var s,r,q,p=this.$ti
p.D(c).h("1/(2)").a(a)
s=$.y
if(s===B.h){if(b!=null&&!t.Q.b(b)&&!t.w.b(b))throw A.e(A.eo(b,"onError",u.c))}else{c.h("@<0/>").D(p.c).h("1(2)").a(a)
if(b!=null)b=A.lx(b,s)}r=new A.C(s,c.h("C<0>"))
q=b==null?1:3
this.b1(new A.bd(r,q,a,b,p.h("@<1>").D(c).h("bd<1,2>")))
return r},
eP(a,b){return this.bG(a,null,b)},
cv(a,b,c){var s,r=this.$ti
r.D(c).h("1/(2)").a(a)
s=new A.C($.y,c.h("C<0>"))
this.b1(new A.bd(s,19,a,b,r.h("@<1>").D(c).h("bd<1,2>")))
return s},
e2(a){this.a=this.a&1|16
this.c=a},
aw(a){this.a=a.a&30|this.a&1
this.c=a.c},
b1(a){var s,r=this,q=r.a
if(q<=3){a.a=t.F.a(r.c)
r.c=a}else{if((q&4)!==0){s=t._.a(r.c)
if((s.a&24)===0){s.b1(a)
return}r.aw(s)}A.ej(null,null,r.b,t.M.a(new A.fh(r,a)))}},
cg(a){var s,r,q,p,o,n,m=this,l={}
l.a=a
if(a==null)return
s=m.a
if(s<=3){r=t.F.a(m.c)
m.c=a
if(r!=null){q=a.a
for(p=a;q!=null;p=q,q=o)o=q.a
p.a=r}}else{if((s&4)!==0){n=t._.a(m.c)
if((n.a&24)===0){n.cg(a)
return}m.aw(n)}l.a=m.aC(a)
A.ej(null,null,m.b,t.M.a(new A.fm(l,m)))}},
ad(){var s=t.F.a(this.c)
this.c=null
return this.aC(s)},
aC(a){var s,r,q
for(s=a,r=null;s!=null;r=s,s=q){q=s.a
s.a=r}return r},
dH(a){var s,r=this,q=r.$ti
q.h("1/").a(a)
if(q.h("an<1>").b(a))A.fk(a,r,!0)
else{s=r.ad()
q.c.a(a)
r.a=8
r.c=a
A.be(r,s)}},
c2(a){var s,r=this
r.$ti.c.a(a)
s=r.ad()
r.a=8
r.c=a
A.be(r,s)},
dI(a){var s,r,q=this
if((a.a&16)!==0){s=q.b===a.b
s=!(s||s)}else s=!1
if(s)return
r=q.ad()
q.aw(a)
A.be(q,r)},
b7(a){var s=this.ad()
this.e2(a)
A.be(this,s)},
bZ(a){var s=this.$ti
s.h("1/").a(a)
if(s.h("an<1>").b(a)){this.c0(a)
return}this.dC(a)},
dC(a){var s=this
s.$ti.c.a(a)
s.a^=2
A.ej(null,null,s.b,t.M.a(new A.fj(s,a)))},
c0(a){A.fk(this.$ti.h("an<1>").a(a),this,!1)
return},
b3(a){this.a^=2
A.ej(null,null,this.b,t.M.a(new A.fi(this,a)))},
$ian:1}
A.fh.prototype={
$0(){A.be(this.a,this.b)},
$S:0}
A.fm.prototype={
$0(){A.be(this.b,this.a.a)},
$S:0}
A.fl.prototype={
$0(){A.fk(this.a.a,this.b,!0)},
$S:0}
A.fj.prototype={
$0(){this.a.c2(this.b)},
$S:0}
A.fi.prototype={
$0(){this.a.b7(this.b)},
$S:0}
A.fp.prototype={
$0(){var s,r,q,p,o,n,m,l,k=this,j=null
try{q=k.a.a
j=q.b.b.eL(t.fO.a(q.d),t.z)}catch(p){s=A.b0(p)
r=A.aZ(p)
if(k.c&&t.n.a(k.b.a.c).a===s){q=k.a
q.c=t.n.a(k.b.a.c)}else{q=s
o=r
if(o==null)o=A.h6(q)
n=k.a
n.c=new A.a6(q,o)
q=n}q.b=!0
return}if(j instanceof A.C&&(j.a&24)!==0){if((j.a&16)!==0){q=k.a
q.c=t.n.a(j.c)
q.b=!0}return}if(j instanceof A.C){m=k.b.a
l=new A.C(m.b,m.$ti)
j.bG(new A.fq(l,m),new A.fr(l),t.H)
q=k.a
q.c=l
q.b=!1}},
$S:0}
A.fq.prototype={
$1(a){this.a.dI(this.b)},
$S:5}
A.fr.prototype={
$2(a,b){A.bL(a)
t.l.a(b)
this.a.b7(new A.a6(a,b))},
$S:13}
A.fo.prototype={
$0(){var s,r,q,p,o,n,m,l
try{q=this.a
p=q.a
o=p.$ti
n=o.c
m=n.a(this.b)
q.c=p.b.b.bF(o.h("2/(1)").a(p.d),m,o.h("2/"),n)}catch(l){s=A.b0(l)
r=A.aZ(l)
q=s
p=r
if(p==null)p=A.h6(q)
o=this.a
o.c=new A.a6(q,p)
o.b=!0}},
$S:0}
A.fn.prototype={
$0(){var s,r,q,p,o,n,m,l=this
try{s=t.n.a(l.a.a.c)
p=l.b
if(p.a.eC(s)&&p.a.e!=null){p.c=p.a.ey(s)
p.b=!1}}catch(o){r=A.b0(o)
q=A.aZ(o)
p=t.n.a(l.a.a.c)
if(p.a===r){n=l.b
n.c=p
p=n}else{p=r
n=q
if(n==null)n=A.h6(p)
m=l.b
m.c=new A.a6(p,n)
p=m}p.b=!0}},
$S:0}
A.e8.prototype={}
A.ee.prototype={}
A.cU.prototype={$iis:1}
A.ed.prototype={
eN(a){var s,r,q
t.M.a(a)
try{if(B.h===$.y){a.$0()
return}A.iU(null,null,this,a,t.H)}catch(q){s=A.b0(q)
r=A.aZ(q)
A.fN(A.bL(s),t.l.a(r))}},
eO(a,b,c){var s,r,q
c.h("~(0)").a(a)
c.a(b)
try{if(B.h===$.y){a.$1(b)
return}A.iV(null,null,this,a,b,t.H,c)}catch(q){s=A.b0(q)
r=A.aZ(q)
A.fN(A.bL(s),t.l.a(r))}},
cF(a){return new A.fy(this,t.M.a(a))},
ee(a,b){return new A.fz(this,b.h("~(0)").a(a),b)},
eL(a,b){b.h("0()").a(a)
if($.y===B.h)return a.$0()
return A.iU(null,null,this,a,b)},
bF(a,b,c,d){c.h("@<0>").D(d).h("1(2)").a(a)
d.a(b)
if($.y===B.h)return a.$1(b)
return A.iV(null,null,this,a,b,c,d)},
eM(a,b,c,d,e,f){d.h("@<0>").D(e).D(f).h("1(2,3)").a(a)
e.a(b)
f.a(c)
if($.y===B.h)return a.$2(b,c)
return A.ly(null,null,this,a,b,c,d,e,f)},
cV(a,b,c,d){return b.h("@<0>").D(c).D(d).h("1(2,3)").a(a)}}
A.fy.prototype={
$0(){return this.a.eN(this.b)},
$S:0}
A.fz.prototype={
$1(a){var s=this.c
return this.a.eO(this.b,s.a(a),s)},
$S(){return this.c.h("~(0)")}}
A.fO.prototype={
$0(){A.jE(this.a,this.b)},
$S:0}
A.cG.prototype={
gC(a){var s=this,r=new A.bf(s,s.r,s.$ti.h("bf<1>"))
r.c=s.e
return r},
gl(a){return this.a},
k(a,b){var s,r,q=this
q.$ti.c.a(b)
if(typeof b=="string"&&b!=="__proto__"){s=q.b
return q.bX(s==null?q.b=A.hj():s,b)}else if(typeof b=="number"&&(b&1073741823)===b){r=q.c
return q.bX(r==null?q.c=A.hj():r,b)}else return q.dz(b)},
dz(a){var s,r,q,p=this
p.$ti.c.a(a)
s=p.d
if(s==null)s=p.d=A.hj()
r=J.af(a)&1073741823
q=s[r]
if(q==null)s[r]=[p.be(a)]
else{if(p.c5(q,a)>=0)return!1
q.push(p.be(a))}return!0},
a_(a,b){var s=this
if(typeof b=="string"&&b!=="__proto__")return s.cj(s.b,b)
else if(typeof b=="number"&&(b&1073741823)===b)return s.cj(s.c,b)
else return s.e_(b)},
e_(a){var s,r,q,p,o=this.d
if(o==null)return!1
s=J.af(a)&1073741823
r=o[s]
q=this.c5(r,a)
if(q<0)return!1
p=r.splice(q,1)[0]
if(0===r.length)delete o[s]
this.cz(p)
return!0},
G(a){var s=this
if(s.a>0){s.b=s.c=s.d=s.e=s.f=null
s.a=0
s.bc()}},
bX(a,b){this.$ti.c.a(b)
if(t.R.a(a[b])!=null)return!1
a[b]=this.be(b)
return!0},
cj(a,b){var s
if(a==null)return!1
s=t.R.a(a[b])
if(s==null)return!1
this.cz(s)
delete a[b]
return!0},
bc(){this.r=this.r+1&1073741823},
be(a){var s,r=this,q=new A.ec(r.$ti.c.a(a))
if(r.e==null)r.e=r.f=q
else{s=r.f
s.toString
q.c=s
r.f=s.b=q}++r.a
r.bc()
return q},
cz(a){var s=this,r=a.c,q=a.b
if(r==null)s.e=q
else r.b=q
if(q==null)s.f=r
else q.c=r;--s.a
s.bc()},
c5(a,b){var s,r
if(a==null)return-1
s=a.length
for(r=0;r<s;++r)if(J.al(a[r].a,b))return r
return-1}}
A.ec.prototype={}
A.bf.prototype={
gA(){var s=this.d
return s==null?this.$ti.c.a(s):s},
q(){var s=this,r=s.c,q=s.a
if(s.b!==q.r)throw A.e(A.a7(q))
else if(r==null){s.d=null
return!1}else{s.d=s.$ti.h("1?").a(r.a)
s.c=r.b
return!0}},
$iX:1}
A.q.prototype={
gC(a){return new A.av(a,this.gl(a),A.bm(a).h("av<q.E>"))},
L(a,b){return this.j(a,b)},
gP(a){return this.gl(a)===0},
gby(a){return!this.gP(a)},
aW(a,b){return A.ic(a,b,null,A.bm(a).h("q.E"))},
aV(a,b,c,d,e){var s,r,q,p,o
A.bm(a).h("h<q.E>").a(d)
A.du(b,c,this.gl(a))
s=c-b
if(s===0)return
A.cm(e,"skipCount")
if(t.j.b(d)){r=e
q=d}else{q=J.ju(d,e).cW(0,!1)
r=0}p=J.ek(q)
if(r+s>p.gl(q))throw A.e(A.jL())
if(r<b)for(o=s-1;o>=0;--o)this.n(a,b+o,p.j(q,r+o))
else for(o=0;o<s;++o)this.n(a,b+o,p.j(q,r+o))},
i(a){return A.h8(a,"[","]")},
$ik:1,
$ih:1,
$im:1}
A.bx.prototype={
Z(a,b){var s,r,q,p=this,o=A.ae(p)
o.h("~(1,2)").a(b)
for(s=new A.b4(p,p.r,p.e,o.h("b4<1>")),o=o.y[1];s.q();){r=s.d
q=p.j(0,r)
b.$2(r,q==null?o.a(q):q)}},
gl(a){return this.a},
gP(a){return this.a===0},
i(a){return A.he(this)},
$iaP:1}
A.ew.prototype={
$2(a,b){var s,r=this.a
if(!r.a)this.b.a+=", "
r.a=!1
r=this.b
s=A.n(a)
r.a=(r.a+=s)+": "
s=A.n(b)
r.a+=s},
$S:12}
A.bz.prototype={
i(a){return A.h8(this,"{","}")},
$ik:1,
$ih:1,
$ihg:1}
A.cM.prototype={}
A.fC.prototype={
bs(a){var s,r,q=a.length,p=A.du(0,null,q),o=new Uint8Array(p)
for(s=0;s<p;++s){if(!(s<q))return A.l(a,s)
r=a.charCodeAt(s)
if((r&4294967040)!==0)throw A.e(A.eo(a,"string","Contains invalid characters."))
if(!(s<p))return A.l(o,s)
o[s]=r}return o}}
A.d3.prototype={}
A.d5.prototype={}
A.cc.prototype={
i(a){var s=A.d7(this.a)
return(this.b!=null?"Converting object to an encodable object failed:":"Converting object did not return an encodable object:")+" "+s}}
A.de.prototype={
i(a){return"Cyclic error in JSON stringify"}}
A.dd.prototype={
ep(a,b){var s=A.kj(a,this.ger().b,null)
return s},
ger(){return B.R}}
A.es.prototype={}
A.fv.prototype={
d_(a){var s,r,q,p,o,n,m=a.length
for(s=this.c,r=0,q=0;q<m;++q){p=a.charCodeAt(q)
if(p>92){if(p>=55296){o=p&64512
if(o===55296){n=q+1
n=!(n<m&&(a.charCodeAt(n)&64512)===56320)}else n=!1
if(!n)if(o===56320){o=q-1
o=!(o>=0&&(a.charCodeAt(o)&64512)===55296)}else o=!1
else o=!0
if(o){if(q>r)s.a+=B.f.a0(a,r,q)
r=q+1
o=A.O(92)
s.a+=o
o=A.O(117)
s.a+=o
o=A.O(100)
s.a+=o
o=p>>>8&15
o=A.O(o<10?48+o:87+o)
s.a+=o
o=p>>>4&15
o=A.O(o<10?48+o:87+o)
s.a+=o
o=p&15
o=A.O(o<10?48+o:87+o)
s.a+=o}}continue}if(p<32){if(q>r)s.a+=B.f.a0(a,r,q)
r=q+1
o=A.O(92)
s.a+=o
switch(p){case 8:o=A.O(98)
s.a+=o
break
case 9:o=A.O(116)
s.a+=o
break
case 10:o=A.O(110)
s.a+=o
break
case 12:o=A.O(102)
s.a+=o
break
case 13:o=A.O(114)
s.a+=o
break
default:o=A.O(117)
s.a+=o
o=A.O(48)
s.a=(s.a+=o)+o
o=p>>>4&15
o=A.O(o<10?48+o:87+o)
s.a+=o
o=p&15
o=A.O(o<10?48+o:87+o)
s.a+=o
break}}else if(p===34||p===92){if(q>r)s.a+=B.f.a0(a,r,q)
r=q+1
o=A.O(92)
s.a+=o
o=A.O(p)
s.a+=o}}if(r===0)s.a+=a
else if(r<m)s.a+=B.f.a0(a,r,m)},
b6(a){var s,r,q,p
for(s=this.a,r=s.length,q=0;q<r;++q){p=s[q]
if(a==null?p==null:a===p)throw A.e(new A.de(a,null))}B.a.k(s,a)},
aR(a){var s,r,q,p,o=this
if(o.cZ(a))return
o.b6(a)
try{s=o.b.$1(a)
if(!o.cZ(s)){q=A.hX(a,null,o.gcc())
throw A.e(q)}q=o.a
if(0>=q.length)return A.l(q,-1)
q.pop()}catch(p){r=A.b0(p)
q=A.hX(a,r,o.gcc())
throw A.e(q)}},
cZ(a){var s,r,q=this
if(typeof a=="number"){if(!isFinite(a))return!1
q.c.a+=B.b.i(a)
return!0}else if(a===!0){q.c.a+="true"
return!0}else if(a===!1){q.c.a+="false"
return!0}else if(a==null){q.c.a+="null"
return!0}else if(typeof a=="string"){s=q.c
s.a+='"'
q.d_(a)
s.a+='"'
return!0}else if(t.j.b(a)){q.b6(a)
q.eU(a)
s=q.a
if(0>=s.length)return A.l(s,-1)
s.pop()
return!0}else if(t.eO.b(a)){q.b6(a)
r=q.eV(a)
s=q.a
if(0>=s.length)return A.l(s,-1)
s.pop()
return r}else return!1},
eU(a){var s,r,q=this.c
q.a+="["
s=J.ek(a)
if(s.gby(a)){this.aR(s.j(a,0))
for(r=1;r<s.gl(a);++r){q.a+=","
this.aR(s.j(a,r))}}q.a+="]"},
eV(a){var s,r,q,p,o,n,m=this,l={}
if(a.gP(a)){m.c.a+="{}"
return!0}s=a.gl(a)*2
r=A.hd(s,null,!1,t.X)
q=l.a=0
l.b=!0
a.Z(0,new A.fw(l,r))
if(!l.b)return!1
p=m.c
p.a+="{"
for(o='"';q<s;q+=2,o=',"'){p.a+=o
m.d_(A.H(r[q]))
p.a+='":'
n=q+1
if(!(n<s))return A.l(r,n)
m.aR(r[n])}p.a+="}"
return!0}}
A.fw.prototype={
$2(a,b){var s,r
if(typeof a!="string")this.a.b=!1
s=this.b
r=this.a
B.a.n(s,r.a++,a)
B.a.n(s,r.a++,b)},
$S:12}
A.fu.prototype={
gcc(){var s=this.c.a
return s.charCodeAt(0)==0?s:s}}
A.et.prototype={}
A.aM.prototype={
F(a,b){if(b==null)return!1
return b instanceof A.aM&&this.a===b.a&&this.b===b.b&&this.c===b.c},
gp(a){return A.dp(this.a,this.b,B.i,B.i)},
K(a,b){var s
t.A.a(b)
s=B.c.K(this.a,b.a)
if(s!==0)return s
return B.c.K(this.b,b.b)},
eQ(){var s=this
if(s.c)return s
return new A.aM(s.a,s.b,!0)},
i(a){var s=this,r=A.jC(A.i6(s)),q=A.d6(A.i4(s)),p=A.d6(A.i1(s)),o=A.d6(A.i2(s)),n=A.d6(A.i3(s)),m=A.d6(A.i5(s)),l=A.hU(A.jX(s)),k=s.b,j=k===0?"":A.hU(k)
k=r+"-"+q
if(s.c)return k+"-"+p+" "+o+":"+n+":"+m+"."+l+j+"Z"
else return k+"-"+p+" "+o+":"+n+":"+m+"."+l+j},
$ia_:1}
A.aN.prototype={
F(a,b){if(b==null)return!1
return b instanceof A.aN&&this.a===b.a},
gp(a){return B.c.gp(this.a)},
K(a,b){return B.c.K(this.a,t.B.a(b).a)},
i(a){var s,r,q,p=this.a,o=p%36e8,n=B.c.J(o,6e7)
o%=6e7
s=n<10?"0":""
r=B.c.J(o,1e6)
q=r<10?"0":""
return""+(p/36e8|0)+":"+s+n+":"+q+r+"."+B.f.al(B.c.i(o%1e6),6,"0")},
$ia_:1}
A.ff.prototype={
i(a){return this.dM()}}
A.A.prototype={
ga8(){return A.jW(this)}}
A.d_.prototype={
i(a){var s=this.a
if(s!=null)return"Assertion failed: "+A.d7(s)
return"Assertion failed"}}
A.az.prototype={}
A.am.prototype={
gb9(){return"Invalid argument"+(!this.a?"(s)":"")},
gb8(){return""},
i(a){var s=this,r=s.c,q=r==null?"":" ("+r+")",p=s.d,o=p==null?"":": "+A.n(p),n=s.gb9()+q+o
if(!s.a)return n
return n+s.gb8()+": "+A.d7(s.gbx())},
gbx(){return this.b}}
A.cl.prototype={
gbx(){return A.iH(this.b)},
gb9(){return"RangeError"},
gb8(){var s,r=this.e,q=this.f
if(r==null)s=q!=null?": Not less than or equal to "+A.n(q):""
else if(q==null)s=": Not greater than or equal to "+A.n(r)
else if(q>r)s=": Not in inclusive range "+A.n(r)+".."+A.n(q)
else s=q<r?": Valid value range is empty":": Only valid value is "+A.n(r)
return s}}
A.d8.prototype={
gbx(){return A.c(this.b)},
gb9(){return"RangeError"},
gb8(){if(A.c(this.b)<0)return": index must not be negative"
var s=this.f
if(s===0)return": no indices are valid"
return": index should be less than "+s},
gl(a){return this.f}}
A.cu.prototype={
i(a){return"Unsupported operation: "+this.a}}
A.dC.prototype={
i(a){return"UnimplementedError: "+this.a}}
A.bA.prototype={
i(a){return"Bad state: "+this.a}}
A.d4.prototype={
i(a){var s=this.a
if(s==null)return"Concurrent modification during iteration."
return"Concurrent modification during iteration: "+A.d7(s)+"."}}
A.dq.prototype={
i(a){return"Out of Memory"},
ga8(){return null},
$iA:1}
A.cq.prototype={
i(a){return"Stack Overflow"},
ga8(){return null},
$iA:1}
A.fg.prototype={
i(a){return"Exception: "+this.a}}
A.h.prototype={
cW(a,b){var s=A.ae(this).h("h.E")
if(b)s=A.a1(this,s)
else{s=A.a1(this,s)
s.$flags=1
s=s}return s},
gl(a){var s,r=this.gC(this)
for(s=0;r.q();)++s
return s},
gP(a){return!this.gC(this).q()},
gby(a){return!this.gP(this)},
aW(a,b){return A.k1(this,b,A.ae(this).h("h.E"))},
gbv(a){var s=this.gC(this)
if(!s.q())throw A.e(A.hV())
return s.gA()},
L(a,b){var s,r
A.cm(b,"index")
s=this.gC(this)
for(r=b;s.q();){if(r===0)return s.gA();--r}throw A.e(A.h7(b,b-r,this,"index"))},
i(a){return A.jN(this,"(",")")}}
A.N.prototype={
gp(a){return A.w.prototype.gp.call(this,0)},
i(a){return"null"}}
A.w.prototype={$iw:1,
F(a,b){return this===b},
gp(a){return A.ck(this)},
i(a){return"Instance of '"+A.ds(this)+"'"},
gB(a){return A.bW(this)},
toString(){return this.i(this)}}
A.ef.prototype={
i(a){return""},
$iaS:1}
A.eL.prototype={
geo(){var s,r=this.b
if(r==null)r=$.dt.$0()
s=r-this.a
if($.hH()===1000)return s
return B.c.J(s,1000)}}
A.dw.prototype={
gC(a){return new A.by(this.a)}}
A.by.prototype={
gA(){return this.d},
q(){var s,r,q,p=this,o=p.b=p.c,n=p.a,m=n.length
if(o===m){p.d=-1
return!1}if(!(o<m))return A.l(n,o)
s=n.charCodeAt(o)
r=o+1
if((s&64512)===55296&&r<m){if(!(r<m))return A.l(n,r)
q=n.charCodeAt(r)
if((q&64512)===56320){p.c=r+1
p.d=65536+((s&1023)<<10)+(q&1023)
return!0}}p.c=r
p.d=s
return!0},
$iX:1}
A.Y.prototype={
gl(a){return this.a.length},
i(a){var s=this.a
return s.charCodeAt(0)==0?s:s},
$ik3:1}
A.ez.prototype={
i(a){return"Promise was rejected with a value of `"+(this.a?"undefined":"null")+"`."}}
A.h0.prototype={
$1(a){return this.a.a4(this.b.h("0/?").a(a))},
$S:3}
A.h1.prototype={
$1(a){if(a==null)return this.a.cI(new A.ez(a===undefined))
return this.a.cI(a)},
$S:3}
A.b1.prototype={}
A.aQ.prototype={}
A.cr.prototype={
bC(a){var s,r,q,p,o,n="Da Lucia",m=A.io(this),l=this.I(),k=l.a,j=l.b
m.ax=$.bo()
m.ay=new A.J(new A.j(238,232,218,255),100)
m.aJ(0,0,k,j)
m.ay=new A.J(new A.j(196,216,170,255),100)
s=B.b.u(k*0.62)
r=B.b.u(k*0.3)
m.cK(s,14,r,70,10)
m.ax=new A.bb(new A.j(150,190,215,255),14,100)
s=t.b
m.en(A.d([new A.r(0,j-30),new A.r(r,j-50),new A.r(B.b.u(k*0.7),j-20),new A.r(k,j-40)],s))
m.ax=new A.bb($.bp(),9,100)
for(r=[0.18,0.5,0.82],q=j-60,p=0;p<3;++p){o=B.b.u(k*r[p])
m.aI(o,0,o,q)}m.aI(0,110,k,110)
m.aI(0,40,B.b.u(k*0.55),40)
r=B.b.u(k*0.18)
q=B.b.u(k*0.82)
o=$.c_()
m.ax=new A.bb(o,3,103)
m.em(A.d([new A.r(r,40),new A.r(r,110),new A.r(q,110)],s))
m.ax=$.bo()
m.ay=new A.J(new A.j(70,80,110,255),100)
m.cK(r-30,24,60,32,6)
m.a=A.ah(11,70,90,700)
m.CW=$.bp()
m.E("Station",r-23,32)
m.ay=new A.J(o,100)
m.aH(q,88,13)
m.bu(A.d([new A.r(q-9,95),new A.r(q+9,95),new A.r(q,110)],s))
m.ay=$.hM()
m.aH(q,88,5)
m.CW=$.bZ()
m.a=A.ah(12,70,90,700)
s=m.d6(n).a
m.E(n,Math.min(q-B.c.J(s,2),k-s-6),116)
m.a=A.ah(10,70,90,400)
m.CW=$.em()
m.E("Via Roma",8,92)
m.E("Riverside",8,j-26)}}
A.cn.prototype={
dr(a){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c=this
c.aD(c.gbB())
s=v.G
r=s.wxc
q=c.RG
q===$&&A.b()
q=q.d
q===$&&A.b()
r.setPaintFixed(q,!0)
p=A.ik()
o=A.aW(c,-1,"Pizzeria Da Lucia",2)
o.V(A.ah(40,72,93,700))
o.dy=$.bp()
o.N()
p.m(-1,A.aC(70,70))
p.m(-1,A.Z(o,0,0,0))
n=A.aW(c,-1,"Neapolitan wood-fired pizza \xb7 since 1987",2)
n.V(A.ah(17,70,90,400))
n.dy=new A.j(255,246,228,255)
n.N()
p.m(-1,A.aC(6,6))
p.m(-1,A.Z(n,0,0,0))
p.m(-1,A.aC(156,156))
m=c.aF(p,"Benvenuti!",B.y)
c.cN=m.a
c.bD(m,"At Lucia's the dough rises for 48 hours, the tomatoes come from Vesuvius and the mozzarella arrives from Campania twice a week. Our wood-fired oven heats up to 450 \xb0C \u2013 your pizza is ready in 90 seconds.")
c.bD(m,"Open Tuesday to Sunday, 12:00\u201314:30 and 18:00\u201323:00. Closed on Mondays. Book a table on 0761 123 456.")
m.b.m(-1,A.aC(16,16))
l=c.aF(p,"Getting here",B.ah)
q=c.cO=l.a
c.bD(l,"Via Roma 12, 79098 Freiburg (sample address). It is a five-minute walk from the station: down Station Street, turn left into Via Roma and walk on to the park. There is parking in the multi-storey car park by the river.")
r=l.b
k=t.e
j=t.y
i=new A.cr(A.d([],k),q,-1,B.e,B.B,0,B.d,new A.G(0,0,0,0),B.d,A.d([],j))
i.S(q,-1,B.e,B.B,0)
i.z=B.as
i.b2()
i.aD(i.gbB())
r.m(-1,A.Z(i,0,8304,16))
j=new A.cB(new A.j(26,95,180,255),new A.j(42,127,212,255),new A.j(106,61,154,255),A.d([],k),q,-1,B.e,B.d,2097161,B.d,new A.G(0,0,0,0),B.d,A.d([],j))
j.S(q,-1,B.e,B.d,2097161)
j.t="https://www.openstreetmap.org"
s=s.wxc
q=j.d
q===$&&A.b()
s.setTextAlign(q,"center",!1)
j.aU("Plan your route in OpenStreetMap")
j.a6()
r.m(-1,A.Z(j,0,240,16))
h=c.aF(p,"Menu",B.ap)
c.cP=h.a
for(s=$.hK(),g=0;g<6;++g)c.cC(h,s[g])
f=c.aF(p,"Drinks",B.ai)
c.cQ=f.a
for(s=$.hJ(),g=0;g<3;++g)c.cC(f,s[g])
e=A.aW(c,-1,"All prices in euros incl. VAT \xb7 All details are sample data.",2)
e.dy=$.bp()
e.N()
p.m(-1,A.aC(24,24))
p.m(-1,A.Z(e,0,0,0))
p.m(-1,A.aC(24,24))
d=A.f4()
d.cD(1)
d.m(-1,A.e2(p,0,8192,0))
d.cD(1)
c.dm(d,!0)
if(c.rx===0&&c.ry===0)c.ry=c.rx=10},
ap(a){var s,r,q,p,o,n,m=this,l=m.cR
if(l!=null)l.aY()
s=m.aT().b
r=m.I()
l=m.k1
Math.max(r.a,l.a)
q=Math.max(0,Math.max(r.b,l.b)-m.I().b)
p=a.bf()
l=a.Q
l.a===$&&A.b()
l=l.b
l===$&&A.b()
o=Math.min(q,Math.max(0,l-p.b+m.aT().b-12))
if(s===o)return
n=Math.min(700,250+B.c.J(Math.abs(o-s),6))
$.hH()
l=new A.e5(new A.eL())
l.a=t.ge.a(new A.eJ(m,s,o))
l.d=2
l.c=n
m.cR=l
l.df()},
aF(a,b,c){var s,r,q,p=new A.dY(A.d([],t.e),this,-1,B.e,B.A,524288,B.d,new A.G(0,0,0,0),B.d,A.d([],t.y))
p.S(this,-1,B.e,B.A,524288)
p.fr=$.jo()
p.N()
s=A.k8(8)
r=A.f4()
r.m(-1,A.Z(A.iq(p,-1,A.hi(c,B.ax,$.c_())),0,2080,10))
q=A.aW(p,-1,b,0)
q.V(A.ah(26,72,90,700))
q.dy=$.bZ()
q.N()
r.m(-1,A.Z(q,0,2048,0))
s.m(-1,A.e2(r,0,112,20))
p.dc(s)
a.m(-1,A.aC(20,20))
a.m(-1,A.Z(p,0,8192,0))
return new A.cL(p,s)},
bD(a,b){var s,r=A.aW(a.a,-1,b,2)
r.V(A.ah(15,70,90,400))
r.dy=$.bZ()
r.N()
s=a.b
s.m(-1,A.Z(r,0,8304,16))
s.m(-1,A.aC(4,4))},
cC(a,b){var s,r,q,p,o,n,m,l,k,j,i,h=a.a,g=A.f4(),f=$.hL()
g.m(-1,A.Z(A.iq(h,-1,A.hi(b.b,B.au,f)),0,2080,8))
s=A.aW(h,-1,b.a,0)
s.V(A.ah(18,70,90,700))
s.dy=f
s.N()
g.m(-1,A.Z(s,0,2048,0))
f=a.b
f.m(-1,A.e2(g,0,112,20))
r=new A.e3(A.d([],t.e),h,-1,B.e,B.d,4,B.d,new A.G(0,0,0,0),B.d,A.d([],t.y))
r.S(h,-1,B.e,B.d,4)
f.m(-1,A.Z(r,0,8304,20))
for(r=b.c,q=r.length,p=0;p<r.length;r.length===q||(0,A.u)(r),++p){o=r[p]
n=A.f4()
m=A.ik()
l=A.aW(h,-1,o.a,2)
l.V(A.ah(15,70,90,700))
l.dy=$.bZ()
l.N()
m.m(-1,A.Z(l,0,8192,0))
k=o.b
if(k.length!==0){j=A.aW(h,-1,k,2)
j.V(A.ah(13,70,90,400))
j.dy=$.em()
j.N()
m.m(-1,A.Z(j,0,8256,2))}n.m(-1,A.e2(m,1,32,16))
i=A.aW(h,-1,"\u20ac"+B.b.an(o.c,2),0)
i.V(A.ah(15,70,90,700))
i.dy=$.c_()
i.N()
n.m(-1,A.Z(i,0,0,0))
f.m(-1,A.e2(n,0,8304,20))}f.m(-1,A.aC(16,16))},
bC(a){var s,r,q,p,o,n=this,m=A.io(n),l=n.I(),k=l.a,j=l.b
m.d7(new A.G(0,0,k,B.b.u(j*0.62)),new A.j(244,170,110,255),new A.j(120,160,210,255),64)
m.ax=$.bo()
m.ay=new A.J(new A.j(255,226,160,200),100)
s=B.b.u(k*0.78)
r=B.b.u(j*0.36)
m.aH(s,r,46)
m.ay=new A.J(new A.j(255,244,214,255),100)
m.aH(s,r,30)
n.aM(m,k,j,0.48,0.05,new A.j(150,150,170,255),1.3)
n.aM(m,k,j,0.56,0.06,new A.j(122,140,110,255),2.1)
n.eT(m,B.b.u(k*0.28),B.b.u(j*0.55))
n.aM(m,k,j,0.66,0.07,new A.j(110,128,70,255),3.2)
n.aM(m,k,j,0.78,0.06,new A.j(132,140,66,255),4.4)
m.ax=new A.bb(new A.j(96,110,50,255),2,100)
for(q=0;q<9;++q){p=B.b.u(j*(0.82+q*0.022))
m.aI(0,p+q*3,k,p-8+q*2)}for(q=0;q<7;++q){o=B.b.u(k*(0.55+q*0.065))
p=B.b.u(j*(0.66-q*0.012))
s=22-q*2
m.ax=$.bo()
m.ay=new A.J(new A.j(40,66,36,255),100)
r=s*4
m.bt(o-B.c.J(s,4),p-r,B.c.J(s,2),r)
m.ay=new A.J(new A.j(60,40,30,255),100)
m.aJ(o-1,p-3,3,6)}},
aM(a,b,c,d,e,f,g){var s,r,q,p,o,n,m,l=A.d([new A.r(0,c)],t.b)
for(s=b/12,r=c*d,q=c*e,p=g*2,o=0;o<=B.b.ag(s);++o){n=Math.min(b,o*12)
m=n/b
B.a.k(l,new A.r(n,B.b.u(r-q*(Math.sin(m*5+g)*0.6+Math.sin(m*11+p)*0.4))))}B.a.k(l,new A.r(b,c))
a.ax=$.bo()
a.ay=new A.J(f,100)
a.cJ(l,2)},
eT(a,b,c){var s,r,q,p,o,n,m,l,k=[B.a_,B.a0,B.a1,B.a2]
for(s=t.b,r=0;r<4;++r){q=k[r].a
p=q[0]
o=q[1]
n=q[2]
m=q[3]
a.ax=$.bo()
a.ay=new A.J(new A.j(236,214,180,255),100)
q=b+p
l=c+o-m
a.aJ(q,l,n,m)
a.ay=new A.J(new A.j(186,92,60,255),100)
a.bu(A.d([new A.r(q-2,l),new A.r(q+B.c.J(n,2),l-8),new A.r(q+n+2,l)],s))}a.ay=new A.J(new A.j(226,200,160,255),100)
q=c-52
a.aJ(b+30,q,10,34)
a.ay=new A.J(new A.j(186,92,60,255),100)
a.bu(A.d([new A.r(b+28,q),new A.r(b+35,c-64),new A.r(b+42,q)],s))}}
A.eJ.prototype={
$1(a){var s,r,q=this.b
q=B.b.u(q+(this.c-q)*a)
s=v.G.wxc
r=this.a.RG
r===$&&A.b()
r=r.d
r===$&&A.b()
s.scrollTo(r,-1,q)},
$S:14}
A.df.prototype={
gef(){var s=this.e
s===$&&A.b()
return s},
dn(){var s=this,r=t.dX.a(A.d([],t.g4))
s.e!==$&&A.j8()
s.e=r
r=new A.ex(s)
r.$2("Food",$.hK())
r.$2("Drinks",$.hJ())
s.eD()},
cY(a,b,c){var s,r,q,p,o,n,m,l=A.d([],t.s)
for(s=a.split(" "),r=s.length,q="",p=0;p<r;++p){o=s[p]
n=q.length===0
m=n?o:q+" "+o
if(!n&&b.aj(m)>c){B.a.k(l,q)
q=o}else q=m}if(q.length!==0)B.a.k(l,q)
return l},
eD(){var s,r,q,p,o,n,m=t.t,l=A.d([],m),k=this.f,j=220,i=0
for(;;){s=this.e
s===$&&A.b()
r=s.length
if(!(i<r))break
q=s[i]
p=q.b
if(q.c!=null&&i+1<r){o=i+1
if(!(o<r))return A.l(s,o)
n=p+s[o].b}else n=p
if(j+n>751.89&&l.length!==0){B.a.k(k,l)
l=A.d([],m)
j=50}B.a.k(l,i)
j+=p;++i}if(l.length!==0)B.a.k(k,l)},
aE(){var s=0,r=A.bP(t.gc),q,p=this,o,n,m,l,k,j,i,h,g,f
var $async$aE=A.bT(function(a,b){if(a===1)return A.bM(b,r)
for(;;)switch(s){case 0:o=new A.C($.y,t.fg)
n=new Uint8Array(65536)
m=t.t
l=A.d([],m)
k=t.N
j=t.S
i=A.d([],t.ct)
h=A.hm()
g=A.d([],t.q)
f=A.d([],t.bJ)
s=3
return A.aG(new A.ba("Menu Pizzeria Da Lucia","Pizzeria Da Lucia",new A.fG(new A.dV(n,new A.aF(o,t.gz)),null,A.d([0],m)),l,A.bw(k,j),A.bw(k,k),A.bw(k,j),A.bw(k,k),A.bw(k,k),new A.Y(""),A.hc(k),A.hc(k),i,h,g,f,A.iu(),A.iu(),A.d([],t.eR),new A.fs(),$.jq(),$.cY(),A.d([],t.eB)).U(p.f.length,p.geJ()),$async$aE)
case 3:q=o
s=1
break
case 1:return A.bN(q,r)}})
return A.bO($async$aE,r)},
eK(a8,a9){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1,a2,a3,a4,a5,a6,a7=this
if(a9===0){a7.el(a8)
s=220}else s=50
r=a7.f
if(!(a9<r.length))return A.l(r,a9)
q=r[a9]
p=q.length
o=a7.a
n=a7.b
m=a7.c
l=a7.d
k=0
for(;k<q.length;q.length===p||(0,A.u)(q),++k){j=q[k]
i=a7.e
i===$&&A.b()
if(!(j<i.length))return A.l(i,j)
h=i[j]
g=h.c
i=g!=null
if(i&&B.f.bT(g,"#")){i=B.f.b_(g,1)
f=$.bZ()
e=a8.ry
e.y=l
e.z=f
a8.E(i,50,s+8)
a8.bO($.c_(),1.5)
i=s+40
a8.aZ(50,i,545.28,i)}else if(i){i=$.hL()
f=a8.ry
f.y=m
f.z=i
a8.E(g,50,s+10)}else{d=h.a
i=d.a
f=$.bZ()
e=a8.ry
c=e.y=o
e.z=f
a8.E(i,50,s)
b="\u20ac"+B.b.an(d.c,2)
f=$.c_()
e=c.aj(b)
a=a8.ry
a.y=c
a.z=f
a8.E(b,545.28-e,s)
a0=50+c.aj(i)+6
a1=545.28-c.aj(b)-6
if(a1>a0){a8.bP(new A.j(190,175,160,255),101,0.6)
i=s+10
a8.aZ(a0,i,a1,i)}a2=s+15
i=d.b
if(i.length!==0)for(i=a7.cY(i,n,405.28),f=i.length,a3=0;a3<i.length;i.length===f||(0,A.u)(i),++a3){a4=i[a3]
e=$.em()
c=a8.ry
c.y=n
c.z=e
a8.E(a4,50,a2)
a2+=11}}s+=h.b}a8.bO(new A.j(220,205,190,255),0.5)
a8.aZ(50,777.89,545.28,777.89)
a5=A.b9(A.bU(74,!1,!1),8)
q=$.em()
p=a8.ry
p.y=a5
p.z=q
a8.E("Pizzeria Da Lucia \xb7 Via Roma 12 \xb7 Tel. 0761 123 456 \xb7 All prices in euros incl. VAT \xb7 Sample data",50,783.89)
a6="Page "+(a9+1)+" of "+r.length
r=a5.aj(a6)
p=a8.ry
p.y=a5
p.z=q
a8.E(a6,545.28-r,783.89)},
el(a){var s,r,q,p,o,n
a.eF()
a.ej(50,50,495.28,146)
s=$.bo()
r=a.ry
q=s.c
r.a=q!==106
r.b=s.a
r.c=s.b
r.d=q
r.e=130
r.f=121
r.r=null
a.aq(new A.J(new A.j(232,168,112,255),100))
if(a.T("drawRectangle"))a.bh(A.t(50)+" "+A.t(50)+" "+A.t(495.28)+" "+A.t(146)+" re\n")
a.aq(new A.J(new A.j(250,226,170,255),100))
a.bt(416.50719999999995,96.72,44,44)
p=new A.ey(a)
p.$4(0.62,0.08,new A.j(150,150,170,255),1.3)
p.$4(0.74,0.08,new A.j(122,140,110,255),2.1)
p.$4(0.88,0.07,new A.j(110,128,70,255),3.2)
a.aq(new A.J(new A.j(40,66,36,255),100))
for(s=v.G,o=0;o<6;++o){q=o*2
n=new A.Y("")
new A.bE(n,A.U(new s.Path2D())).eb(50+495.28*(0.56+o*0.07)-4,50+146*(0.86-o*0.02)-34+q,8,34-q)
if(a.T("drawEllipse")){q=n.a
a.bh(q.charCodeAt(0)==0?q:q)}}a.eE()
s=A.b9(A.bU(72,!0,!0),32)
q=$.bp()
n=a.ry
n.y=s
n.z=q
a.E("Pizzeria Da Lucia",70,70)
q=A.b9(A.bU(74,!1,!1),11)
n=a.ry
n.y=q
n.z=new A.j(255,246,228,255)
a.E("Neapolitan wood-fired pizza \xb7 since 1987",72,112)}}
A.ex.prototype={
$2(a,b){var s,r,q,p,o,n,m,l,k,j
t.da.a(b)
s=this.a
B.a.k(s.gef(),new A.bh(null,46,"#"+a))
for(r=b.length,q=0;q<b.length;b.length===r||(0,A.u)(b),++q){p=b[q]
o=s.e
o===$&&A.b()
B.a.k(o,new A.bh(null,34,p.a))
for(n=p.c,m=n.length,l=0;l<n.length;n.length===m||(0,A.u)(n),++l){k=n[l]
j=k.b
B.a.k(o,new A.bh(k,16+(j.length===0?0:s.cY(j,s.b,405.28).length)*11+7,null))}}},
$S:16}
A.ey.prototype={
$4(a,b,c,d){var s,r,q,p,o,n=A.im()
n.ak(50,196)
for(s=50+146*a,r=146*b,q=d*2,p=0;p<=40;++p){o=p/40
n.cB(50+495.28*p/40,s-r*(Math.sin(o*5+d)*0.6+Math.sin(o*11+q)*0.4))}n.cB(545.28,196)
n.bp()
s=this.a
s.aq(new A.J(c,100))
s.ew(n)},
$S:17}
A.F.prototype={
dq(){var s,r,q,p=this,o=2147483648,n=t.e,m=t.y,l=new A.cn($.aJ(),A.d([],n),p,-1,B.e,B.d,o,B.d,new A.G(0,0,0,0),B.d,A.d([],m))
l.S(p,-1,B.e,B.d,o)
l.RG=l
l.dD(l)
l.dr(p)
s=new A.bG(A.d([],t.az),A.d([],n),p,-1,B.e,B.d,260,B.d,new A.G(0,0,0,0),B.d,A.d([],m))
s.S(p,-1,B.e,B.d,260)
p.cM=s
n=v.G.wxc
m=p.d
m===$&&A.b()
r=s.d
r===$&&A.b()
n.attachToolBar(m,r)
p.ca()
n=new A.eI()
s.af(100,"Welcome",n.$1(B.y))
s.af(101,"Directions",n.$1(B.al))
s.af(102,"Menu",n.$1(B.z))
s.af(103,"Drinks",n.$1(B.p))
q=new A.aD()
q.r=-1
s.c9(-1,q)
s.af(104,"PDF",n.$1(B.aj))
s.ck()
n=p.a
B.a.k(n,new A.aU(new A.eD(l),101,100))
B.a.k(n,new A.aU(new A.eE(l),101,101))
B.a.k(n,new A.aU(new A.eF(l),101,102))
B.a.k(n,new A.aU(new A.eG(l),101,103))
B.a.k(n,new A.aU(new A.eH(p),101,104))}}
A.eI.prototype={
$1(a){return A.hi(a,B.av,$.c_())},
$S:18}
A.eD.prototype={
$1(a){var s=this.a,r=s.cN
r===$&&A.b()
return s.ap(r)},
$S:1}
A.eE.prototype={
$1(a){var s=this.a,r=s.cO
r===$&&A.b()
return s.ap(r)},
$S:1}
A.eF.prototype={
$1(a){var s=this.a,r=s.cP
r===$&&A.b()
return s.ap(r)},
$S:1}
A.eG.prototype={
$1(a){var s=this.a,r=s.cQ
r===$&&A.b()
return s.ap(r)},
$S:1}
A.eH.prototype={
$1(a){var s=0,r=A.bP(t.H),q=this,p,o
var $async$$1=A.bT(function(b,c){if(b===1)return A.bM(c,r)
for(;;)switch(s){case 0:p=A
o=q.a
s=3
return A.aG(A.jS().aE(),$async$$1)
case 3:s=2
return A.aG(p.h3(o,c,"Menu Da Lucia.pdf","Menu of Pizzeria Da Lucia","application/pdf"),$async$$1)
case 2:return A.bN(null,r)}})
return A.bO($async$$1,r)},
$S:20}
A.dv.prototype={}
A.J.prototype={}
A.j.prototype={
d4(){var s,r=new A.eU(),q=r.$1(this.a)
if(typeof q!=="number")return A.hA(q)
s=r.$1(this.b)
if(typeof s!=="number")return A.hA(s)
r=r.$1(this.c)
if(typeof r!=="number")return A.hA(r)
return 0.2126*q+0.7152*s+0.0722*r},
F(a,b){var s=this
if(b==null)return!1
if(s===b)return!0
return b instanceof A.j&&b.a===s.a&&b.b===s.b&&b.c===s.c&&b.d===s.d},
gp(a){var s=this
return A.dp(s.a,s.b,s.c,s.d)},
ei(a){var s,r,q,p,o,n=this
if(a===100)return new A.j(n.a,n.b,n.c,n.d)
a=B.c.aG(a,0,200)
s=(a-100)/100
if(a>100){s=1-s
r=255}else{s=1+s
r=0}q=B.b.aG(r+s*(n.a-r),0,255)
p=B.b.aG(r+s*(n.b-r),0,255)
o=B.b.aG(r+s*(n.c-r),0,255)
return new A.j(B.b.aL(q),B.b.aL(p),B.b.aL(o),n.d)}}
A.eU.prototype={
$1(a){var s=a/255
return s<=0.04045?s/12.92:Math.pow((s+0.055)/1.055,2.4)},
$S:21}
A.o.prototype={
F(a,b){if(b==null)return!1
return b instanceof A.o&&this.a===b.a&&this.b===b.b},
gp(a){return this.a*this.b}}
A.r.prototype={
F(a,b){if(b==null)return!1
return b instanceof A.r&&this.a===b.a&&this.b===b.b},
gp(a){return this.a*this.b}}
A.G.prototype={
F(a,b){var s,r,q,p=this
if(b==null)return!1
s=!1
if(b instanceof A.G){r=p.a
r===$&&A.b()
q=b.a
q===$&&A.b()
if(r===q){r=p.b
r===$&&A.b()
q=b.b
q===$&&A.b()
if(r===q){r=p.d
r===$&&A.b()
q=b.d
q===$&&A.b()
if(r===q){s=p.c
s===$&&A.b()
r=b.c
r===$&&A.b()
r=s===r
s=r}}}}return s},
gp(a){var s,r,q,p=this,o=p.a
o===$&&A.b()
s=p.b
s===$&&A.b()
r=p.c
r===$&&A.b()
q=p.d
q===$&&A.b()
return o*s*r*q}}
A.dU.prototype={
bw(){var s=0,r=A.bP(t.H)
var $async$bw=A.bT(function(a,b){if(a===1)return A.bM(b,r)
for(;;)switch(s){case 0:return A.bN(null,r)}})
return A.bO($async$bw,r)}}
A.dV.prototype={
gl(a){return this.b},
k(a,b){var s,r,q,p,o,n,m=this
t.L.a(b)
if(m.c)throw A.e(A.dy("WxPDFUint8ListOutput: add() after close()"))
s=m.b
r=s+b.length
q=m.a
p=q.length
if(r>p){o=p*2
while(o<r)o*=2
n=new Uint8Array(o)
B.n.bQ(n,0,s,q)
m.a=n
s=n}else s=q
B.n.bQ(s,m.b,r,b)
m.b=r},
Y(){var s=0,r=A.bP(t.H),q,p=this,o,n,m,l
var $async$Y=A.bT(function(a,b){if(a===1)return A.bM(b,r)
for(;;)switch(s){case 0:if(p.c){s=1
break}p.c=!0
o=p.a
n=p.b
m=o.BYTES_PER_ELEMENT
l=A.du(0,n,B.c.a9(o.byteLength,m))
p.d.a4(J.jr(B.n.geg(o),o.byteOffset+0*m,l*m))
case 1:return A.bN(q,r)}})
return A.bO($async$Y,r)}}
A.f3.prototype={}
A.fG.prototype={
a3(){var s=this.d
B.a.k(s,0)
return s.length-1},
am(a){var s=B.l.bs(a)
this.a.k(0,s)
this.c=this.c+s.length},
cG(a){t.L.a(a)
this.a.k(0,a)
this.c=this.c+a.length},
a7(a,b){B.a.n(this.d,a,this.c)
this.am(""+a+" 0 obj\n"+b+"\nendobj\n")},
eR(a,b){var s,r,q,p,o,n,m,l=this
for(s=l.d,r=l.a,q=1;p=s.length,q<p;++q)if(s[q]===0){B.a.n(s,q,l.c)
o=B.l.bs(""+q+" 0 obj\nnull\nendobj\n")
r.k(0,o)
l.c=l.c+o.length}n=l.c
r=""+p
m="xref\n0 "+r+"\n0000000000 65535 f \n"
for(q=1;q<p;++q)m+=B.f.al(B.c.i(s[q]),10,"0")+" 00000 n \n"
s=m+("trailer\n<< /Size "+r+" /Root "+a+" 0 R /Info "+b+" 0 R >>\n")+("startxref\n"+n+"\n%%EOF\n")
l.am(s.charCodeAt(0)==0?s:s)}}
A.eh.prototype={}
A.fL.prototype={
$1(a){return B.f.al(B.c.i(a),2,"0")},
$S:9}
A.ei.prototype={}
A.ba.prototype={
U(a,b){return this.d0(a,t.c.a(b))},
d0(a,b){var s=0,r=A.bP(t.v),q,p=this,o,n,m,l,k,j,i,h
var $async$U=A.bT(function(c,d){if(c===1)return A.bM(d,r)
for(;;)switch(s){case 0:p.aX(p.ay)
o=p.cy.a,n=t.H,m=p.RG,l=t.D,k=0
case 3:if(!(k<a)){s=5
break}p.bS(595.28,841.89)
j=b.$2(p,k)
if(!(j instanceof A.C)){i=new A.C($.y,l)
i.a=8
i.c=j
j=i}s=6
return A.aG(j,$async$U)
case 6:j=m.length,h=0
case 7:if(!(h<m.length)){s=9
break}s=10
return A.aG(m[h].f3(),$async$U)
case 10:case 8:m.length===j||(0,A.u)(m),++h
s=7
break
case 9:p.aK()
s=11
return A.aG(o.bw(),$async$U)
case 11:s=12
return A.aG(A.jH(B.m,n),$async$U)
case 12:case 4:++k
s=3
break
case 5:s=13
return A.aG(p.Y(),$async$U)
case 13:q=!0
s=1
break
case 1:return A.bN(q,r)}})
return A.bO($async$U,r)},
Y(){var s=0,r=A.bP(t.H),q=this
var $async$Y=A.bT(function(a,b){if(a===1)return A.bM(b,r)
for(;;)switch(s){case 0:if(q.db&&!q.dx)q.es()
s=2
return A.aG(q.cy.a.Y(),$async$Y)
case 2:return A.bN(null,r)}})
return A.bO($async$Y,r)},
aX(a){var s,r=this
if(r.db)return
r.db=!0
if(r.ay.length===0)r.ay=a
s=r.cy
s.am("%PDF-1.4\n")
s.cG(B.V)
r.dy=s.a3()
r.fr=s.a3()
r.fx=s.a3()},
es(){var s,r,q,p,o=this
if(!o.db)o.aX(o.ay)
if(o.dx)return
if(o.ok)o.aK()
s=o.cy
r=o.fy
if(r.length===0){o.bS(0,0)
o.aK()}o.go.Z(0,new A.f0(s))
o.k1.Z(0,new A.f1(o,s))
q=A.R(r)
p=new A.aw(r,q.h("z(1)").a(new A.f2()),q.h("aw<1,z>")).cU(0," ")
s.a7(o.fr,"<< /Type /Pages /Kids ["+p+"] /Count "+r.length+" >>")
s.a7(o.dy,"<< /Type /Catalog /Pages "+o.fr+" 0 R >>")
r="<< /Producer "+A.fM("wxDart PDF")
q=o.ay
if(q.length!==0)r+=" /Title "+A.fM(q)
q=o.ch
if(q.length!==0)r+=" /Author "+A.fM(q)
q=A.fM("wxDart")
r=r+(" /Creator "+q)+(" /CreationDate "+A.lv(new A.aM(Date.now(),0,!1))+" >>")
s.a7(o.fx,r.charCodeAt(0)==0?r:r)
s.eR(o.dy,o.fx)
o.dx=!0},
bS(a,b){var s,r,q=this
if(!q.db)q.aX(q.ay)
if(q.ok)q.aK()
q.ok=!0
q.p1=a>0?a:595.28
q.p2=b>0?b:841.89
q.p3=new A.Y("")
q.p4.G(0)
q.R8.G(0)
B.a.G(q.RG)
q.rx=!1
q.ry=A.hm()
B.a.G(q.to)
B.a.G(q.x1)
q.xr=q.x2=null
s=q.p3
r="1 0 0 -1 0 "+A.t(q.p2)+" cm\n"
s.a+=r},
aK(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c=this,b="<< /ProcSet [/PDF /Text /ImageB /ImageC]"
if(!c.ok)return
c.ok=!1
s=c.x1.length+c.to.length
for(r=0;r<s;++r)c.p3.a+="Q\n"
q=c.cy
for(p=c.RG,o=p.length,n=0;n<p.length;p.length===o||(0,A.u)(p),++n){m=p[n]
if(!m.gf1())m.f0(q)}l=q.a3()
o=c.p3.a
k=t.L.a(B.l.bs(o.charCodeAt(0)==0?o:o))
B.a.n(q.d,l,q.c)
o=""+l
q.am(o+" 0 obj\n<<  /Length "+k.length+" >>\nstream\n")
q.cG(k)
q.am("\nendstream\nendobj\n")
j=new A.Y(b)
i=c.p4
if(i.a!==0){j.a="<< /ProcSet [/PDF /Text /ImageB /ImageC] /Font <<"
for(i=A.iv(i,i.r,i.$ti.c),h=c.id,g=c.go,f=i.$ti.c;i.q();){e=i.d
if(e==null)e=f.a(e)
e=" /"+A.n(h.j(0,e))+" "+A.n(g.j(0,e))+" 0 R"
j.a+=e}i=j.a+=" >>"}else i=b
h=p.length
if(h!==0){i=j.a=i+" /XObject <<"
for(n=0;n<p.length;p.length===h||(0,A.u)(p),++n){m=p[n]
i=" /"+A.n(m.gf_())+" "+A.n(m.geZ())+" 0 R"
i=j.a+=i}p=i+" >>"
j.a=p}else p=i
i=c.R8
if(i.a!==0){j.a=p+" /ExtGState <<"
for(p=A.iv(i,i.r,i.$ti.c),i=c.k1,h=p.$ti.c;p.q();){g=p.d
if(g==null)g=h.a(g)
g=" /"+g+" "+A.n(i.j(0,g))+" 0 R"
j.a+=g}p=j.a+=" >>"}j.a=p+" >>"
d=q.a3()
q.a7(d,"<< /Type /Page /Parent "+c.fr+" 0 R /MediaBox [0 0 "+A.t(c.p1)+" "+A.t(c.p2)+"] /Resources "+j.i(0)+" /Contents "+o+" 0 R >>")
B.a.k(c.fy,d)
c.p3=new A.Y("")},
bP(a,b,c){var s=this.ry
s.a=b!==106
s.b=a
s.c=c
s.d=b
s.e=130
s.f=121
s.r=null},
bO(a,b){return this.bP(a,100,b)},
aq(a){var s=this.ry
s.w=a.b!==106
s.x=a.a},
ej(a,b,c,d){var s,r,q=this
if(!q.T("clip"))return
B.a.k(q.x1,q.ry.Q)
s=q.p3
r="q "+A.t(a)+" "+A.t(b)+" "+A.t(c)+" "+A.t(d)+" re W n\n"
s.a+=r},
eF(){var s,r,q=this
if(!q.T("pushState"))return
q.p3.a+="q\n"
B.a.k(q.to,q.ry)
s=q.ry
r=A.hm()
r.a=s.a
r.b=s.b
r.c=s.c
r.d=s.d
r.e=s.e
r.f=s.f
r.r=s.r
r.w=s.w
r.x=s.x
r.y=s.y
r.z=s.z
r.Q=s.Q
r.as=s.as
r.as=q.x1.length
q.ry=r},
eE(){var s,r,q,p,o=this
if(!o.T("popState"))return
s=o.to
if(s.length===0){A.ar("error","[error]: ","WxPDFGraphicsContext.popState() without pushState()")
return}r=o.ry.as
for(q=o.x1,p=q.length;p>r;--p)o.p3.a+="Q\n"
B.a.eG(q,r,q.length)
o.p3.a+="Q\n"
if(0>=s.length)return A.l(s,-1)
o.ry=s.pop()
o.xr=o.x2=null},
ew(a){var s,r=this,q=r.dX(a,"fillPath")
if(q==null||!r.ry.w)return
r.bg(r.ry.x)
s=r.p3
s.a=(s.a+=q.d.i(0))+"f*\n"},
aZ(a,b,c,d){var s,r,q=this
if(!q.T("strokeLine")||!q.ry.a)return
q.ce()
s=q.p3
r=A.t(a)+" "+A.t(b)+" m "+A.t(c)+" "+A.t(d)+" l S\n"
s.a+=r},
bt(a,b,c,d){var s,r,q,p,o,n=A.im(),m=c/2,l=d/2,k=a+m,j=b+l,i=0.5522847498307936*m,h=0.5522847498307936*l,g=k+m
n.ak(g,j)
s=j+h
r=k+i
q=j+l
n.X(g,s,r,q,k,q)
p=k-i
o=k-m
n.X(p,q,o,s,o,j)
s=j-h
q=j-l
n.X(o,s,p,q,k,q)
n.X(r,q,g,s,g,j)
n.bp()
if(this.T("drawEllipse")){g=n.d.a
this.bh(g.charCodeAt(0)==0?g:g)}},
E(a,b,c){var s,r,q,p,o,n,m,l,k,j,i=this
if(!i.T("drawText")||a.length===0)return
s=i.ry
r=s.y
i.bg(s.z)
s=r.a
q=i.id
p=q.j(0,s)
if(p==null){p="F"+(q.a+1)
q.n(0,s,p)
i.go.n(0,s,i.cy.a3())}i.p4.k(0,s)
s=r.b
o=new A.Y("BT /"+p+" "+A.t(s)+" Tf\n")
n=c+r.ged()
for(q=a.split("\n"),m=q.length,l=r.c,s=l.b*s/1000+-l.c*s/1000,k=0;k<m;++k){j=q[k]
if(j.length!==0){l="1 0 0 -1 "+A.t(b)+" "+A.t(n)+" Tm "+r.eq(j)+" Tj\n"
o.a+=l}n+=s}o.a+="ET\n"
i.p3.a+=o.i(0)},
T(a){if(this.ok)return!0
A.ar("error","[error]: ","WxPDFGraphicsContext."+a+" called outside of startPage()/endPage()")
return!1},
dX(a,b){if(!this.T(b))return null
if(!(a instanceof A.bE)){A.ar("error","[error]: ","WxPDFGraphicsContext."+b+": path was not created by a WxPDFGraphicsContext")
return null}return a},
bh(a){var s,r,q=this,p=q.ry,o=p.w,n=p.a
if(!o&&!n)return
if(o)q.bg(p.x)
if(n)q.ce()
p=q.p3
s=p.a+=a
if(o&&n)r="B*\n"
else r=o?"f*\n":"S\n"
p.a=s+r},
ce(){var s,r,q,p,o=this,n=o.ry,m=A.iS(n.b,"RG"),l=A.t(n.c),k=n.e
A:{if(132===k){s="0"
break A}if(131===k){s="2"
break A}s="1"
break A}r=n.f
B:{if(122===r){q="1"
break B}if(120===r){q="2"
break B}q="0"
break B}q=m+(l+" w ")+s+" J "+q+" j "+o.dY(n.d,n.c)+" d\n"+o.cd("CA",A.hv(n.b)[3]/255)
p=q.charCodeAt(0)==0?q:q
if(p!==o.x2){o.p3.a+=p
o.x2=p}},
bg(a){var s=this,r=A.iS(a,"rg")+s.cd("ca",A.hv(a)[3]/255)
if(r!==s.xr){s.p3.a+=r
s.xr=r}},
dY(a,b){var s=new A.eZ(Math.max(b,1))
switch(a){case 101:return s.$1(A.d([1,2],t.u))
case 102:return s.$1(A.d([8,4],t.u))
case 103:return s.$1(A.d([4,4],t.u))
case 104:return s.$1(A.d([8,3,1,3],t.u))
default:return"[] 0"}},
cd(a,b){var s,r,q,p=this
if(b>=1&&!p.rx)return""
p.rx=!0
s="/"+a+" "+A.t(b)
r=p.k2
q=r.j(0,s)
if(q==null){q="GS"+(r.a+1)
r.n(0,s,q)
p.k3.n(0,q,s)
p.k1.n(0,q,p.cy.a3())}p.R8.k(0,q)
return"/"+q+" gs\n"}}
A.f0.prototype={
$2(a,b){A.H(a)
this.a.a7(A.c(b),"<< /Type /Font /Subtype /Type1 /BaseFont /"+a+" /Encoding /WinAnsiEncoding >>")},
$S:8}
A.f1.prototype={
$2(a,b){A.H(a)
this.b.a7(A.c(b),"<< /Type /ExtGState "+A.n(this.a.k3.j(0,a))+" >>")},
$S:8}
A.f2.prototype={
$1(a){return""+A.c(a)+" 0 R"},
$S:9}
A.eZ.prototype={
$1(a){var s
t.dg.a(a)
s=A.R(a)
return"["+new A.aw(a,s.h("z(1)").a(new A.f_(this.a)),s.h("aw<1,z>")).cU(0," ")+"] 0"},
$S:24}
A.f_.prototype={
$1(a){return A.t(A.ac(a)*this.a)},
$S:38}
A.bE.prototype={
ak(a,b){var s=this,r=s.d,q=A.t(a)+" "+A.t(b)+" m\n"
r.a+=q
s.e=!0
s.w=a
s.x=b},
bp(){if(!this.e)return
this.d.a+="h\n"
this.e=!0},
cB(a,b){var s,r,q=this
if(!q.e){q.ak(a,b)
return}s=q.d
r=A.t(a)+" "+A.t(b)+" l\n"
s.a+=r
q.e=!0},
X(a,b,c,d,e,f){var s,r,q=this
if(!q.e)q.ak(a,b)
s=q.d
r=A.t(a)+" "+A.t(b)+" "+A.t(c)+" "+A.t(d)+" "+A.t(e)+" "+A.t(f)+" c\n"
s.a+=r
q.e=!0},
eb(a,b,c,d){var s,r,q,p,o,n=this,m=c/2,l=d/2,k=a+m,j=b+l,i=0.5522847498307936*m,h=0.5522847498307936*l,g=k+m
n.ak(g,j)
s=j+h
r=k+i
q=j+l
n.X(g,s,r,q,k,q)
p=k-i
o=k-m
n.X(p,q,o,s,o,j)
s=j-h
q=j-l
n.X(o,s,p,q,k,q)
n.X(r,q,g,s,g,j)
n.bp()}}
A.W.prototype={}
A.eY.prototype={
ged(){return this.c.b*this.b/1000},
aj(a){var s,r,q,p
for(s=new A.by(a),r=this.c.e,q=0;s.q();){p=A.iZ(s.d)-32
if(!(p>=0&&p<224))return A.l(r,p)
q+=r[p]}return q*this.b/1000},
eq(a){var s,r,q
for(s=new A.by(a),r="(";s.q();){q=A.iZ(s.d)
if(q===40||q===41||q===92)r=r+"\\"+A.O(q)
else r=q<32||q>126?r+("\\"+B.f.al(B.c.cX(q,8),3,"0")):r+A.O(q)}s=r+")"
return s.charCodeAt(0)==0?s:s}}
A.bb.prototype={}
A.a9.prototype={}
A.P.prototype={}
A.dL.prototype={}
A.dX.prototype={}
A.e7.prototype={}
A.e0.prototype={}
A.dI.prototype={}
A.dF.prototype={}
A.cy.prototype={}
A.aU.prototype={}
A.cz.prototype={
dZ(a){var s
if(this instanceof A.B&&!(this instanceof A.F)){s=this.f
if(s!=null)if(s.v(a))return!0}return!1},
v(a){var s,r,q,p,o,n=a.b
n===$&&A.b()
if(n===111){n=this.c
if(n!=null){n.$1(t.U.a(a))
return!0}return!1}if(n===110)return!1
for(n=this.a,s=n.length-1,r=a instanceof A.a9;s>=0;--s){if(!(s<n.length))return A.l(n,s)
q=n[s]
p=a.b
o=a.a
o===$&&A.b()
if(q.a===p){p=q.b
p=p===-1||p===o}else p=!1
if(p){a.c=!1
if(r)q.c.$1(a)
return!0}}if(a.e<1)return!1
if(this.dZ(a))return!0
return!1},
aD(a){this.c=t.x.a(a)}}
A.dO.prototype={}
A.dP.prototype={}
A.dQ.prototype={}
A.dR.prototype={}
A.dS.prototype={}
A.aV.prototype={}
A.e1.prototype={}
A.e6.prototype={}
A.dG.prototype={}
A.e_.prototype={}
A.Q.prototype={
i(a){return"WxMaterialIcon."+this.a}}
A.dH.prototype={
ac(){var s,r=v.G.wxc,q=this.d
q===$&&A.b()
s=A.U(r.measure(q,-1))
return new A.o(A.c(s.w),A.c(s.h))},
cq(){if(!this.v(A.ir(this.r)))return}}
A.cB.prototype={
ga1(){return"hyperlink"},
aU(a){var s,r
this.cy=a
s=v.G.wxc
r=this.d
r===$&&A.b()
s.setLabel(r,a)
this.aB()},
a6(){var s=this,r=v.G.wxc,q=s.d
q===$&&A.b()
A.ai(r,"linkSet",[q,s.t,A.ad(s.H),A.ad(s.eu),A.ad(s.ev),s.O],t.H)},
cA(a){return a===13||a===370}}
A.cD.prototype={
ga1(){return"staticbitmap"},
d9(a){var s,r=this
r.t=a
r.a6()
r.at=null
r.ae()
s=a.a
s===$&&A.b()
r.ea(s,new A.f5(r,a))},
a6(){var s,r,q=this.t,p=q.a
p===$&&A.b()
s=q.bb()
q=v.G.wxc
r=this.d
r===$&&A.b()
p=p.r
p===$&&A.b()
A.ai(q,"staticBitmapSet",[r,p,s.a,s.b,0],t.H)},
ac(){var s=this.t.bb()
return new A.o(Math.max(s.a,1),Math.max(s.b,1))}}
A.f5.prototype={
$0(){var s=this.a
if(s.t===this.b)s.a6()},
$S:0}
A.e3.prototype={
ga1(){return"staticline"},
ac(){return(this.y&8)!==0?B.ar:B.aw}}
A.e4.prototype={
ga1(){return"statictext"},
aU(a){var s,r
this.cy=a
s=v.G.wxc
r=this.d
r===$&&A.b()
s.setLabel(r,A.m8(a,"&&","&"))
this.aB()},
gc6(){return(this.y&2)!==0&&this.x.a!==-1},
dA(){var s=this.y
if((s&256)!==0)return"center"
if((s&512)!==0)return"right"
return"left"},
bn(){var s,r,q=this,p=v.G.wxc,o=q.d
o===$&&A.b()
s=q.dA()
r=q.gc6()||q.O
p.setTextAlign(o,s,r)},
M(a,b,c){var s=this
if(a!==4||(s.y&2)===0||s.x.a!==-1)return!1
if(b===s.t)return!0
s.t=b
s.at=null
return!0},
ac(){var s,r,q,p,o,n=this
if(n.gc6()){s=v.G.wxc
r=n.d
r===$&&A.b()
q=A.U(s.measure(r,n.x.a))
return new A.o(A.c(q.w),A.c(q.h))}n.O=!1
n.bn()
s=v.G
r=s.wxc
p=n.d
p===$&&A.b()
o=A.U(r.measure(p,-1))
r=n.t
if(r<=0||A.c(o.w)<=r)return new A.o(A.c(o.w),A.c(o.h))
n.O=!0
n.bn()
q=A.U(s.wxc.measure(p,n.t))
return new A.o(n.t,A.c(q.h))}}
A.aD.prototype={}
A.bG.prototype={
ga1(){return"toolbar"},
ck(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d=this
d.H=!1
s=A.d([],t.f)
for(r=d.t,q=r.length,p=t.N,o=t.K,n=0;n<r.length;r.length===q||(0,A.u)(r),++n){m=r[n]
l=m.a
k=d.dT(m)
j=A.lL(m.w)
i=m.x
h=m.d
g=A.hZ(["id",l,"kind",k,"label",j,"help",i,"enabled",!0,"toggled",h,"bitmap",0,"bw",0,"bh",0,"control",0],p,o)
f=m.y
if(f!=null){l=f.a
l===$&&A.b()
e=f.bb()
l=l.r
l===$&&A.b()
g.n(0,"bitmap",l)
g.n(0,"bw",e.a)
g.n(0,"bh",e.b)}B.a.k(s,g)}r=v.G.wxc
q=d.d
q===$&&A.b()
l=d.y
r.toolbarSet(q,B.K.ep(A.hZ(["vertical",(l&8)!==0,"text",(l&256)!==0,"noicons",(l&128)!==0,"separation",5,"tools",s],p,o),null))
d.aB()},
dT(a){var s=a.r
if(s===-1)return"separator"
switch(s){case 1:return"check"
case 2:return"radio"
case 3:return"dropdown"
default:return"normal"}},
bA(){var s,r,q,p=this,o=A.a1(p.t,t.W),n=o.length,m=0
for(;m<o.length;o.length===n||(0,A.u)(o),++m){s=o[m]
r=s.r
if(r===-1)continue
q=A.ir(s.a)
q.ax=s.d
q.ay=!0
p.v(q)}if(p.H)p.ck()},
c9(a,b){var s,r=this
if(a<0||a>r.t.length)a=r.t.length
s=r.t
B.a.cT(s,a,b)
if(b.r===2&&!B.a.ec(s,new A.f7(r,b)))b.d=!0
r.H=!0
A.aq()
return b},
af(a,b,c){var s=new A.aD()
s.a=a===-1?$.fR=$.fR-1:a
s.w=b
s.y=c
return this.c9(-1,s)},
cm(a,b){var s,r,q,p,o,n
if(a.r!==2||b.r!==2)return!1
s=this.t
r=B.a.cS(s,a)
q=B.a.cS(s,b)
if(r<0||q<0)return!1
if(r>q){p=q
q=r
r=p}for(o=s.length,n=r;n<=q;++n){if(!(n>=0&&n<o))return A.l(s,n)
if(s[n].r!==2)return!1}return!0},
e9(a){var s,r,q,p
for(s=this.t,r=s.length,q=0;q<s.length;s.length===r||(0,A.u)(s),++q){p=s[q]
if(this.cm(p,a))p.d=p===a}},
dV(a,b,c,d){var s,r,q=this,p=b>=0?A.jM(q.t,b,t.W):null
switch(a){case"tool":if(p==null)return!1
s=p.r
if(s===1){p.d=!p.d
q.H=!0
A.aq()}else if(s===2){if(p.d)return!0
q.e9(p)
q.H=!0
A.aq()}r=A.eV(101,p.a)
q.v(r)
return!0
case"toolenter":r=A.eV(125,q.r)
q.v(r)
return!1
case"tooldropdown":if(p==null)return!1
q.v(A.eV(126,p.a))
return!0
default:return!1}}}
A.f7.prototype={
$1(a){var s
t.W.a(a)
s=this.b
return a!==s&&this.a.cm(a,s)&&a.d},
$S:26}
A.dE.prototype={
ds(){var s,r,q,p,o,n=v.G
if(A.hn(n.wxc)==null)throw A.e(A.dy('wxDart Web: the runtime wxc.js has not been loaded. Add <script src="wxc.js"></script> to index.html before the Dart code.'))
$.bK.b=this
s=n.wxc
if(typeof A.hF()=="function")A.h2(A.en("Attempting to rewrap a JS function.",null))
r=function(a,b){return function(c){return a(b,c,arguments.length)}}(A.kJ,A.hF())
r[$.hG()]=A.hF()
s.init(r)
this.d8(new A.j(138,184,221,255))
s=A.k_()
s.dk(!0)
q=n.wxc
p=s.d
p===$&&A.b()
o=$.bY!==s&&!s.ax
q.frameChrome(p,o,!1,s.t)
if($.bY!==s)n.wxc.frameHistory(p,!0)},
d8(a){var s,r,q,p=this
p.e=a
p.f=a.ei(60)
s=p.e
v.G.wxc.setAccent(A.ad(s),A.ad(p.d2(s)))
A.lJ()
for(r=$.aI.length,q=0;q<$.aI.length;$.aI.length===r||(0,A.u)($.aI),++q)$.aI[q].ci()},
d2(a){return a.d4()<0.18?new A.j(255,255,255,255):new A.j(0,0,0,255)}}
A.eT.prototype={}
A.i.prototype={
ek(){}}
A.a8.prototype={
cl(){var s,r,q,p,o,n,m,l=this,k=l.a.b
if(k.length===0&&!$.iY){$.iY=!0
A.ar("warn","[warning]: ","Material icons have no outlines yet: run tool/generate_material_icons.py")}s=v.G
r=s.wxc
q=A.ac(r.dpr())
r=l.b
p=B.b.u(r.a*q)
o=Math.max(1,p)
r=B.b.u(r.b*q)
n=Math.max(1,r)
m=l.c
if(m==null)m=A.kN(!1)
s=s.wxc
r=l.r
r===$&&A.b()
A.ai(s,"iconFromPaths",[r,k,o,n,A.ad(m)],t.H)
l.y=!0
l.z=!1
l.Q=o
l.as=n
l.at=q}}
A.fP.prototype={
$1(a){var s=t.O.a(a).r
s===$&&A.b()
return!$.hp.br(s)},
$S:27}
A.cw.prototype={
bb(){var s,r,q,p=this.b
if(p!=null&&p.a>0&&p.b>0)return p
s=this.a
s===$&&A.b()
r=s.Q
q=s.at
return new A.o(B.b.u(r/q),B.b.u(s.as/q))}}
A.f6.prototype={}
A.dZ.prototype={
gbi(){return 1},
gbj(){return 1},
d6(a){var s,r,q,p,o,n,m,l,k=this.a,j=(k==null?$.h4():k).az(),i=a.split("\n")
for(k=i.length,s=v.G,r=0,q=0,p=0,o=0;o<k;++o){n=i[o]
m=A.U(s.wxc.measureText(j,n))
r=Math.max(r,A.ac(m.w))
q=A.ac(m.ascent)
p=A.ac(m.descent)}l=B.b.ag(q+p)
k=B.b.ag(r)
s=i.length
B.b.ag(p)
return new A.f6(k,l*s)}}
A.cx.prototype={
dB(){var s,r,q=this,p=q.as
if(p==null)return
s=q.gbi()
r=q.dy
A.ai(p,"setTransform",[s*r,0,0,q.gbj()*r,(0-0*q.gbi())*r,(0-0*q.gbj())*r],t.H)},
e3(a,b){var s=A.ad(b)
if(s!==this.fr){a.fillStyle=s
this.fr=s}},
aa(a){var s=this.ay
if(s.b===106)return!1
this.e3(a,s.a)
return!0},
W(a){var s,r,q,p,o=this,n=o.ax,m=n.c
if(m===106)return!1
s=A.ad(n.a)
if(s!==o.fx){a.strokeStyle=s
o.fx=s}r=n.b
if(r<=0)r=1
if(r!==o.go){a.lineWidth=r
o.go=r}if(130!==o.k1){o.k1=130
a.lineCap="round"}if(121!==o.k2){o.k2=121
a.lineJoin="miter"}if(m!==o.id){o.id=m
q=t.u
switch(m){case 101:p=A.d([1,2],q)
break
case 102:p=A.d([8,4],q)
break
case 103:p=A.d([4,4],q)
break
case 104:p=A.d([6,3,1,3],q)
break
default:p=A.d([],q)}m=A.R(p)
q=m.h("aw<1,f>")
m=A.a1(new A.aw(p,m.h("f(1)").a(new A.eW(r)),q),q.h("ao.E"))
a.setLineDash(m)}return!0},
cf(){if(!(this.gbi()===1&&this.gbj()===1))return 0
var s=this.ax.b
return((s<=0?1:s)&1)===1?0.5:0},
aI(a,b,c,d){var s,r=this.as
if(r==null||!this.W(r))return
s=this.cf()
r.beginPath()
r.moveTo(a+s,b+s)
r.lineTo(c+s,d+s)
r.stroke()},
em(a){var s,r,q,p
t.a.a(a)
s=this.as
if(s==null||!this.W(s))return
r=this.cf()
s.beginPath()
q=a[0]
s.moveTo(q.a+r,q.b+r)
for(p=1;p<3;++p){q=a[p]
s.lineTo(q.a+r,q.b+r)}s.stroke()},
cJ(a,b){var s,r,q
t.a.a(a)
s=this.as
if(s==null||a.length<2)return
s.beginPath()
if(0>=a.length)return A.l(a,0)
r=a[0]
s.moveTo(r.a,r.b)
for(q=1;q<a.length;++q){r=a[q]
s.lineTo(r.a,r.b)}s.closePath()
if(this.aa(s)){r=b===2?"nonzero":"evenodd"
s.fill(r)}if(this.W(s))s.stroke()},
bu(a){return this.cJ(a,1)},
en(a){var s,r,q,p,o
t.a.a(a)
s=this.as
if(s==null||!this.W(s))return
s.beginPath()
r=a[0]
s.moveTo(r.a,r.b)
for(q=1;q<2;){r=a[q]
p=r.a;++q
o=a[q]
r=r.b
s.quadraticCurveTo(p,r,(p+o.a)/2,(r+o.b)/2)}r=a[2]
p=a[3]
s.quadraticCurveTo(r.a,r.b,p.a,p.b)
s.stroke()},
aJ(a,b,c,d){var s,r,q=this,p=q.as
if(p==null)return
if(q.aa(p))p.fillRect(a,b,c,d)
if(q.W(p)){s=q.ax.b
if(s<=0)s=1
r=s/2
p.strokeRect(a+r,b+r,Math.max(0,c-s),Math.max(0,d-s))}},
cK(a,b,c,d,e){var s,r,q,p,o,n,m,l,k,j,i,h=this,g="arc",f=h.as
if(f==null)return
s=Math.min(e,Math.min(c,d)/2)
r=h.ax
if(r.c!==106){r=r.b
q=r<=0?1:r}else q=0
r=q/2
p=a+r
o=b+r
f.beginPath()
r=p+s
f.moveTo(r,o)
n=p+(c-q)
m=n-s
f.lineTo(m,o)
l=o+s
k=t.H
A.ai(f,g,[m,l,s,-1.5707963267948966,0],k)
j=o+(d-q)
i=j-s
f.lineTo(n,i)
A.ai(f,g,[m,i,s,0,1.5707963267948966],k)
f.lineTo(r,j)
A.ai(f,g,[r,i,s,1.5707963267948966,3.141592653589793],k)
f.lineTo(p,l)
A.ai(f,g,[r,l,s,3.141592653589793,4.71238898038469],k)
f.closePath()
if(h.aa(f))f.fill()
if(h.W(f))f.stroke()},
bt(a,b,c,d){var s,r,q=this.as
if(q==null)return
q.beginPath()
s=c/2
r=d/2
A.ai(q,"ellipse",[a+s,b+r,s,r,0,0,6.283185307179586],t.H)
if(this.aa(q))q.fill()
if(this.W(q))q.stroke()},
aH(a,b,c){var s=this.as
if(s==null)return
s.beginPath()
A.ai(s,"arc",[a,b,c,0,6.283185307179586],t.H)
if(this.aa(s))s.fill()
if(this.W(s))s.stroke()},
E(a,b,c){var s,r,q,p,o,n,m,l,k,j,i,h=this,g=h.as
if(g==null)return
s=h.a
r=(s==null?$.h4():s).az()
if(r!==h.fy){g.font=r
h.fy=r}s=h.a
r=(s==null?$.h4():s).az()
q=a.split("\n")
for(s=q.length,p=v.G,o=c,n=0;n<s;++n){m=q[n]
l=A.U(p.wxc.measureText(r,m))
k=A.ac(l.ascent)
j=A.ac(l.descent)
i=A.ad(h.CW)
if(i!==h.fr){g.fillStyle=i
h.fr=i}g.fillText(m,b,o+A.ac(l.ascent))
o+=k+j}},
d7(a,b,c,d){var s,r,q,p,o,n,m,l=this.as
if(l==null)return
s=a.a
s===$&&A.b()
r=a.b
r===$&&A.b()
q=a.c
q===$&&A.b()
p=s+q
o=a.d
o===$&&A.b()
n=r+o
switch(d){case 16:m=A.U(l.createLinearGradient(p,r,s,r))
break
case 64:m=A.U(l.createLinearGradient(s,n,s,r))
break
case 128:m=A.U(l.createLinearGradient(s,r,s,n))
break
default:m=A.U(l.createLinearGradient(s,r,p,r))}m.addColorStop(0,A.ad(b))
m.addColorStop(1,A.ad(c))
l.fillStyle=m
this.fr=null
l.fillRect(s,r,q,o)}}
A.eW.prototype={
$1(a){return A.ac(a)*this.a},
$S:28}
A.dW.prototype={}
A.dJ.prototype={
az(){var s,r,q,p,o=this,n=o.r
if(n!=null)return n
s=o.b
s===$&&A.b()
switch(s){case 72:case 73:r='"Times New Roman", Times, "Liberation Serif", serif'
break
case 76:r='"SF Mono", Consolas, "Ubuntu Mono", "Courier New", monospace'
break
case 74:case 75:r='Arial, Helvetica, "Liberation Sans", sans-serif'
break
default:r='system-ui, -apple-system, "Segoe UI", Roboto, Ubuntu, sans-serif'}s=o.c
s===$&&A.b()
q=s===93||s===94?"italic ":""
s=o.d
s===$&&A.b()
p=s<=0?400:Math.min(s,900)
s=o.a
s===$&&A.b()
return o.r=q+A.n(p)+" "+B.b.an(s*$.jn(),1)+"px "+r}}
A.dN.prototype={}
A.eb.prototype={}
A.fs.prototype={}
A.dM.prototype={}
A.cA.prototype={}
A.e5.prototype={
gdG(){var s=this.a
s===$&&A.b()
return s},
dE(a){if(a<0.36363636363636365)return 7.5625*a*a
else if(a<0.7272727272727273){a-=0.5454545454545454
return 7.5625*a*a+0.75}else if(a<0.9090909090909091){a-=0.8181818181818182
return 7.5625*a*a+0.9375}else{a-=0.9545454545454546
return 7.5625*a*a+0.984375}},
cs(a){var s
switch(this.d){case 2:s=a*a
return s/(2*(s-a)+1)
case 3:return a*a
case 4:return a*(2-a)
case 5:return this.dE(a)
default:return a}},
df(){var s,r,q,p=this
p.aY()
s=p.f
r=s.b
if(r==null)r=$.dt.$0()
s.a=r
q=s.b
if(q!=null){s.a=r+($.dt.$0()-q)
s.b=null}p.c_(p.cs(0))
p.e=A.k4(B.N,new A.f8(p))},
aY(){var s=this.e
if(s!=null)s.eh()
this.e=null
s=this.f
if(s.b==null)s.b=$.dt.$0()},
c_(a){return this.gdG().$1(a)}}
A.f8.prototype={
$1(a){var s,r
t.p.a(a)
s=this.a
r=s.c<=0?1:Math.min(1,s.f.geo()/s.c)
s.c_(s.cs(r))
if(r>=1)s.aY()
A.aq()
return null},
$S:29}
A.b8.prototype={
M(a,b,c){var s,r,q,p,o,n,m,l,k,j=this.a,i=A.R(j),h=i.h("aB<1>"),g=A.a1(new A.aB(j,i.h("M(1)").a(new A.eR()),h),h.h("h.E"))
j=this.f
j===$&&A.b()
if(a===(j!==8?8:4)){for(j=g.length,s=!1,r=0;r<g.length;g.length===j||(0,A.u)(g),++r)s=B.u.bN(s,g[r].M(a,b,-1))
return s}for(j=g.length,q=0,p=0,r=0;i=g.length,r<i;g.length===j||(0,A.u)(g),++r){o=g[r]
i=o.b
if(i>0)p+=i
else{i=o.ao()
q+=this.f!==8?i.a:i.b}}if(p===0)return!1
n=Math.max(0,b-q)
for(m=p,s=!1,r=0;r<g.length;g.length===i||(0,A.u)(g),++r){o=g[r]
l=o.b
if(l===0)continue
k=B.b.u(n*l/m)
n-=k
m-=l
s=B.u.bN(s,o.M(a,k,-1))}return s},
bo(){var s,r,q,p,o,n,m,l,k,j,i,h,g=this
for(s=g.a,r=s.length,q=0,p=0,o=0,n=0,m=0;m<s.length;s.length===r||(0,A.u)(s),++m){l=s[m]
if(!l.aP())continue
k=l.ao()
j=l.b
if(j>0){q+=j
i=g.f
i===$&&A.b()
o=Math.max(o,(i!==8?k.a:k.b)/j)}else{i=g.f
i===$&&A.b()
p+=i!==8?k.a:k.b}i=i!==8?k.b:k.a
n=Math.max(n,i)}h=p+B.b.ag(o*q)
s=g.f
s===$&&A.b()
return s!==8?new A.o(h,n):new A.o(n,h)},
bE(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e=this,d=e.a,c=A.R(d),b=c.h("aB<1>"),a=A.a1(new A.aB(d,c.h("M(1)").a(new A.eS()),b),b.h("h.E"))
d=a.length
if(d===0)return
c=e.d
b=e.f
b===$&&A.b()
b=b!==8
s=b?c.a:c.b
r=b?c.b:c.a
for(q=0;q<a.length;a.length===d||(0,A.u)(a),++q){p=a[q]
p.M(e.f!==8?8:4,r,-1)}o=e.dK(a,s)
for(d=o.length,n=0,m=0;m<a.length;++m){p=a[m]
l=p.ao()
if(!(m<d))return A.l(o,m)
k=o[m]
j=p.c
c=e.f!==8
i=c?l.b:l.a
if((j&8192)!==0||i>r){i=r
h=0}else if(c)if((j&2048)!==0)h=B.c.J(r-i,2)
else h=(j&1024)!==0?r-i:0
else if((j&256)!==0)h=B.c.J(r-i,2)
else h=(j&512)!==0?r-i:0
b=e.c
g=b.a
b=b.b
f=c?new A.r(g+n,b+h):new A.r(g+h,b+n)
p.da(f,c?new A.o(k,i):new A.o(i,k))
n+=k}},
dK(a,b){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e={}
t.fD.a(a)
s=A.d([],t.t)
for(r=a.length,q=0;p=a.length,q<p;a.length===r||(0,A.u)(a),++q){p=a[q].ao()
o=this.f
o===$&&A.b()
p=o!==8?p.a:p.b
s.push(Math.max(0,p))}n=A.hd(p,-1,!1,t.S)
e.a=b
for(r=a.length,m=0,q=0;q<r;++q)m+=a[q].b
l=new A.eQ(e,s)
if(b<B.a.ex(s,0,new A.eP(),t.o)){for(k=0;k<a.length;++k)if(a[k].b===0)B.a.n(n,k,l.$1(k))
for(k=0;k<a.length;++k)if(a[k].b!==0)B.a.n(n,k,l.$1(k))
return n}for(j=!0;j;){r=a.length
o=e.a
i=s.length
k=0
for(;;){if(!(k<r)){j=!1
break}A:{if(!(k<p))return A.l(n,k)
if(n[k]!==-1)break A
h=a[k].b
if(h!==0){g=B.c.a9(o*h,m)
if(!(k<i))return A.l(s,k)
if(g>=s[k])break A
f=m-h
m=f}if(!(k<i))return A.l(s,k)
B.a.n(n,k,s[k])
r=e.a
if(!(k<s.length))return A.l(s,k)
e.a=r-s[k]
j=!0
break}++k}}for(k=0;k<a.length;++k){if(!(k<p))return A.l(n,k)
if(n[k]!==-1)continue
h=a[k].b
B.a.n(n,k,B.c.a9(e.a*h,m))
e.a=e.a-n[k]
m-=h}return n}}
A.eR.prototype={
$1(a){return t.d.a(a).aP()},
$S:6}
A.eS.prototype={
$1(a){return t.d.a(a).aP()},
$S:6}
A.eQ.prototype={
$1(a){var s,r,q=this.a,p=q.a
if(p<=0)return 0
s=this.b
if(!(a<s.length))return A.l(s,a)
r=Math.min(s[a],p)
q.a=p-r
return r},
$S:31}
A.eP.prototype={
$2(a,b){return A.ho(a)+A.c(b)},
$S:32}
A.bF.prototype={
dM(){return"WxSizerKind."+this.b}}
A.ap.prototype={
aP(){switch(this.a.a){case 3:return!this.f.ax
case 2:var s=this.e.dQ()
return s
default:return!0}},
dF(){var s,r,q,p,o,n,m=this
switch(m.a.a){case 3:s=m.f
r=s.z
q=r.a
q=q!==-1?q:s.x.a
p=r.b
p=p!==-1?p:s.x.b
r=q===-1
if(r||p===-1){o=s.bH()
if(r)q=o.a
if(p===-1)p=o.b}n=new A.o(q,p)
break
case 2:n=m.e.bI()
break
default:n=m.r}return m.a!==B.C?new A.o(Math.max(n.a,-1),Math.max(n.b,-1)):n},
gar(){return(this.c&16)!==0?this.d:0},
gb5(){return(this.c&32)!==0?this.d:0},
gau(){return(this.c&64)!==0?this.d:0},
gb4(){return(this.c&128)!==0?this.d:0},
ao(){var s=this,r=s.dF()
return new A.o(r.a+s.gar()+s.gb5(),r.b+s.gau()+s.gb4())},
M(a,b,c){var s,r=this
if(b<0)return!1
s=Math.max(0,b-(a===4?r.gar()+r.gb5():r.gau()+r.gb4()))
switch(r.a.a){case 3:return r.f.M(a,s,c)
case 2:return r.e.M(a,s,c)
default:return!1}},
da(a,b){var s,r,q,p,o=this,n=a.a,m=a.b,l=b.a,k=b.b
o.y=new A.G(n,m,l,k)
s=n+o.gar()
r=m+o.gau()
q=Math.max(0,l-o.gar()-o.gb5())
p=Math.max(0,k-o.gau()-o.gb4())
switch(o.a.a){case 3:o.f.bl(s,r,q,p)
break
case 2:n=o.e
n.c=new A.r(s,r)
n.d=new A.o(q,p)
n.bE()
break
default:break}}}
A.bc.prototype={
bI(){var s=this.bo()
return new A.o(Math.max(s.a,-1),Math.max(s.b,-1))},
bK(a){var s,r,q,p
for(s=this.a,r=s.length,q=0;q<r;++q){p=s[q]
if(p.f===a)return p}return null},
d5(a){var s,r,q,p
for(s=this.a,r=s.length,q=0;q<r;++q){p=s[q]
if(p.e===a)return p}return null},
dQ(){var s,r,q
for(s=this.a,r=s.length,q=0;q<s.length;s.length===r||(0,A.u)(s),++q)if(s[q].aP())return!0
return!1},
e7(a){var s=this.b
if(s!=null&&a.f!==s)A.ar("error","[error]: ",A.bW(this).i(0)+" has "+A.bW(a).i(0)+" owned by wrong parent window")},
m(a,b){var s,r,q=this,p="[error]: "
if(a<0||a>q.a.length)a=q.a.length
s=b.f
if(s!=null){if(q.bK(s)!=null)A.ar("error",p,A.bW(q).i(0)+": window already added")
q.e7(s)
s.go=q}s=b.e
if(s!=null){if(q.d5(s)!=null)A.ar("error",p,A.bW(q).i(0)+": "+s.gB(0).i(0)+" already added")
r=q.b
if(r!=null)s.bm(r)}B.a.cT(q.a,a,b)
q.a2()
return b},
cD(a){var s=A.aC(0,0)
s.b=a
return this.m(-1,s)},
dO(a){var s=a.f
if(s!=null&&s.go===this)s.go=null},
eI(a){var s=this,r=s.bK(a)
if(r==null)return!1
B.a.a_(s.a,r)
s.dO(r)
s.a2()
return!0},
cH(a,b){var s,r,q,p=this.a,o=A.a1(p,t.d),n=o.length,m=0
for(;m<o.length;o.length===n||(0,A.u)(o),++m){s=o[m]
r=s.f
q=r==null
if(!q&&r.go===this)r.go=null
if(b){if(!q)r.ah()
r=s.e
if(r!=null)r.cH(0,!0)}}B.a.G(p)
this.a2()},
G(a){return this.cH(0,!1)},
bm(a){var s,r,q,p,o,n,m=this
m.b=a
for(s=m.a,r=s.length,q=0;q<s.length;s.length===r||(0,A.u)(s),++q){p=s[q]
o=p.e
if(o!=null)o.bm(a)
o=p.f
if(o!=null){n=m.b
if(n!=null&&o.f!==n)A.ar("error","[error]: ",A.bW(m).i(0)+" has "+A.bW(o).i(0)+" owned by wrong parent window")}}},
a2(){var s=this.b
if(s!=null)s.a2()}}
A.dK.prototype={
dW(a){this.v(A.k9(105,a,null))
return},
ga1(){return"frame"},
bA(){},
ca(){var s,r,q,p,o,n=this
if(n.fy!=null){n.bz()
return}s=n.e
r=A.R(s)
q=r.h("aB<1>")
p=A.a1(new A.aB(s,r.h("M(1)").a(new A.eX(n)),q),q.h("h.E"))
if(p.length===1){o=n.I()
B.a.gbv(p).bl(0,0,o.a,o.b)}},
dP(a,b,c,d){return!1}}
A.eX.prototype={
$1(a){t.h.a(a)
return!(a instanceof A.F)&&a!==this.a.cM&&!a.ax},
$S:33}
A.dY.prototype={}
A.cC.prototype={
ab(){var s=this.y
if((s&2147483648)>>>0!==0&&(s&1073741824)===0)return!1
return!0},
av(){var s=this.y
if((s&1073741824)!==0&&(s&2147483648)>>>0===0)return!1
return!0},
cb(a,b){if(!a)return"hidden"
return b===1?"scroll":"auto"},
dD(a){var s,r,q,p=this
a.id=p
s=v.G.wxc
r=a.d
r===$&&A.b()
q=p.d
q===$&&A.b()
s.setScrollTarget(r,q,p.cb(p.ab(),0),p.cb(p.av(),0))
a.bY()
p.y1=$.aJ()},
aT(){var s,r=v.G.wxc,q=this.RG
q===$&&A.b()
q=q.d
q===$&&A.b()
s=A.U(r.scrollPos(q))
return new A.r(A.c(s.x),A.c(s.y))},
co(a,b,c){var s,r=c>0
if(r)B.c.a9(b,c)
s=new A.e0()
s.b=121
s.a=-1
if(r)B.c.bL(b,c)
this.v(s)}}
A.dT.prototype={}
A.aE.prototype={
dt(a,b,c,d,e,f){var s,r,q=this
q.ax=!0
B.a.k($.aI,q)
s=v.G.wxc
r=q.d
r===$&&A.b()
s.setLabel(r,q.t)},
dd(a){var s,r
this.ax=!1
s=v.G.wxc
r=this.d
r===$&&A.b()
s.show(r,!0)
A.aq()},
ah(){var s=this
if(s.ch)return!0
B.a.a_($.aI,s)
if($.bY===s){$.bY=null
$.bK.a5()}s.dl()
return!0},
c4(a){var s=this.r,r=new A.dF()
r.b=109
r.a=s
r.f=a
if(this.v(r))return!0
this.ah()
return!0},
I(){var s,r,q
if(!this.H){s=v.G.wxc
r=this.d
r===$&&A.b()
q=A.U(s.clientSize(r))
if(A.c(q.w)>0&&A.c(q.h)>0)return new A.o(A.c(q.w),A.c(q.h))}return this.O},
aS(){return this.I()},
bJ(){var s=this.I()
return new A.G(0,0,s.a,s.b)},
dU(a,b){var s,r=this,q=r.H
r.H=!0
if(q){s=r.O
s=s.a===a&&s.b===b}else s=!1
if(s)return
r.O=new A.o(a,b)
r.ca()
r.bk()
if(!q)r.cp()
r.aQ()}}
A.fJ.prototype={
$2(a,b){var s=t.h
s.a(a)
s.a(b)
return B.c.K(a.c3(),b.c3())},
$S:34}
A.B.prototype={
S(a,b,c,d,e){var s,r,q,p,o=this
if(o.r===-1)o.r=$.fR=$.fR-1
s=$.iR
$.iR=s+1
o.d!==$&&A.j8()
o.d=s
$.E.n(0,s,o)
r=o.f
q=r==null
if(!q){B.a.k(r.e,o)
o.w=o.e8(o.w)}p=v.G.wxc
if(q)r=null
else{r=r.d
r===$&&A.b()}if(r==null)r=0
p.createWindow(s,r,o.ga1(),o.y)
o.b2()},
ga1(){return"window"},
ah(){var s,r,q=this
if(q.ch)return!0
s=q.go
if(s!=null)s.eI(q)
q.c7()
s=q.f
if(s!=null)B.a.a_(s.e,q)
s=v.G.wxc
r=q.d
r===$&&A.b()
s.destroyWindow(r)
return!0},
c7(){var s,r,q,p,o,n=this
if(n.ch)return
n.dj()
n.ch=!0
s=n.e
r=A.a1(s,t.h)
q=r.length
p=0
for(;p<r.length;r.length===q||(0,A.u)(r),++p){o=r[p]
if(o instanceof A.F)o.ah()
else o.c7()}B.a.G(s)
s=n.d
s===$&&A.b()
$.E.a_(0,s)
$.bR.a_(0,n)},
ac(){return B.at},
bH(){var s,r,q,p,o,n,m,l,k=this,j=k.fy,i=j!=null
if(i)s=j.bI()
else{s=k.at
if(s==null){s=k.ac()
k.at=s}}r=k.id
if(r!=null){q=r.ab()
p=r.av()
o=s.a
n=s.b
m=!q
if(m)l=i&&p
else l=!0
if(l){o=k.z.a
o=o>0?o:50}if(p&&m)o+=16
m=!p
if(m)i=i&&q
else i=!0
if(i){n=k.z.b
n=n>0?n:50}s=new A.o(o,q&&m?n+16:n)}return s},
ea(a,b){t.M.a(b)
if(a.y||a.z)return
a.w.a.eP(new A.f9(this,b),t.P)},
b2(){var s,r,q,p,o,n,m,l,k=this
if(k instanceof A.F)return
if(k.go!=null&&k.as){k.ae()
return}s=k.x
r=s.a
q=s.b
s=r===-1
if(s||q===-1){p=k.bH()
if(s)r=p.a
if(q===-1)q=p.b}s=k.z
o=s.a
if(o!==-1&&r<o)r=o
n=s.b
if(n!==-1&&q<n)q=n
s=k.w
m=s.a
if(m===-1)m=0
l=s.b
k.bl(m,l===-1?0:l,r,q)},
bl(a,b,c,d){var s,r,q=this,p=q.Q,o=p.c
o===$&&A.b()
if(c===o){o=p.d
o===$&&A.b()
s=d!==o}else s=!0
o=p.a
o===$&&A.b()
if(a===o){p=p.b
p===$&&A.b()
r=b!==p}else r=!0
if(q.as&&!s&&!r)return
q.Q=new A.G(a,b,c,d)
q.as=!0
p=v.G.wxc
o=q.d
o===$&&A.b()
A.ai(p,"setRect",[o,a,b,c,d],t.H)
if(s){q.bk()
if(q.fy!=null)q.bz()
q.aQ()}},
c3(){var s,r=this.f
for(s=0;r!=null;){++s
r=r.f}return s},
a2(){if(this.ch)return
$.bR.k(0,this)
A.aq()},
ae(){var s=this
for(;;){if(!(s.go!=null&&s.f!=null))break
s=s.f
s.a2()
if(s instanceof A.F)break}},
bk(){var s,r,q=this
q.aS()
s=q.r
r=new A.e1(new A.G(0,0,0,0))
r.b=110
r.a=s
r.r=q.bJ()
q.v(r)},
cp(){var s,r,q,p
for(s=this.e,r=s.length,q=0;q<s.length;s.length===r||(0,A.u)(s),++q){p=s[q]
if(p instanceof A.F)continue
p.bk()
p.cp()}},
aS(){var s=this.Q,r=s.c
r===$&&A.b()
s=s.d
s===$&&A.b()
return new A.o(r,s)},
I(){var s,r,q,p=this
if(p.id!=null&&p.as){s=v.G.wxc
r=p.d
r===$&&A.b()
q=A.U(s.clientSize(r))
if(A.c(q.w)>0||A.c(q.h)>0)return new A.o(A.c(q.w),A.c(q.h))}return p.aS()},
bY(){var s,r,q
if(this.id!=null){s=v.G.wxc
r=this.d
r===$&&A.b()
q=this.k1
s.setVirtualSize(r,Math.max(0,q.a),Math.max(0,q.b))}},
M(a,b,c){var s,r,q,p,o=this.fy
if(o==null||b<0)return!1
s=this.id
if(s!=null)r=a===4?s.ab():s.av()
else r=!1
if(r)return!1
q=a===4
p=q?new A.o(b,0):new A.o(0,b)
r=q?p.a:p.b
return o.M(a,Math.max(0,r),-1)},
bJ(){var s,r,q=this.bf(),p=this.Q,o=p.a
o===$&&A.b()
s=p.b
s===$&&A.b()
r=p.c
r===$&&A.b()
p=p.d
p===$&&A.b()
return new A.G(o-q.a,s-q.b,r,p)},
bf(){var s=this.f,r=s==null?null:s.id
if(r==null)return B.aq
return r.aT()},
e8(a){var s,r=a.a,q=r===-1
if(q&&a.b===-1)return a
s=this.bf()
r=q?-1:r+s.a
q=a.b
return new A.r(r,q===-1?-1:q+s.b)},
bR(a,b){var s,r=this,q=r.fy
if(q!=null)s=q!==a
else s=!1
if(s)q.G(0)
r.fy=a
a.bm(r)
r.a2()
r.ae()},
dc(a){return this.bR(a,!0)},
bz(){var s,r,q,p,o,n,m,l,k,j,i,h,g,f=this
$.bR.a_(0,f)
s=f.fy
if(s==null)return!1
r=f.id
if(r==null){q=$.aJ()
p=f.I()
s.c=q
s.d=p
s.bE()
return!0}o=r.ab()
n=f.I()
m=$.aK()
for(q=!o,l=0;l<2;++l,n=i){if(q)s.M(4,n.a,-1)
k=s.bo()
p=Math.max(k.a,-1)
j=Math.max(k.b,-1)
m=new A.o(p,j)
f.k1=o?m:new A.o(Math.min(p,n.a),j)
f.bY()
i=f.I()
p=i.a
j=p===n.a
if(!q||j){n=i
break}if(l===1){s.M(4,p,-1)
k=s.bo()
m=new A.o(Math.max(k.a,-1),Math.max(k.b,-1))}}h=n.a
if(r.ab())h=Math.max(h,m.a)
g=n.b
if(r.av())g=Math.max(g,m.b)
s.c=$.aJ()
s.d=new A.o(h,g)
s.bE()
return!0},
aB(){var s,r=this
r.at=null
if(r.go!=null)r.ae()
else{s=r.x
if(s.a===-1||s.b===-1)r.b2()}},
V(a){var s,r,q,p=this
p.dx=a
s=v.G.wxc
r=p.d
r===$&&A.b()
q=a.az()
s.setFont(r,q)
p.aB()
p.aQ()},
d3(){var s=this.dy
if(s!=null)return s
$.bK.a5()
return new A.j(27,27,27,255)},
d1(){var s=this.fr
if(s!=null)return s
$.bK.a5()
return new A.j(243,243,243,255)},
N(){var s,r,q=v.G.wxc,p=this.d
p===$&&A.b()
s=this.dy
s=s==null?"":A.ad(s)
r=this.fr
r=r==null?"":A.ad(r)
q.setColours(p,s,r)},
aD(a){var s,r,q=this
q.di(t.x.a(a))
if(!q.CW){q.CW=!0
s=v.G.wxc
r=q.d
r===$&&A.b()
s.enablePaint(r)}},
aQ(){var s,r
if(this.CW){s=v.G.wxc
r=this.d
r===$&&A.b()
s.refresh(r)}},
ci(){var s,r,q,p
this.aQ()
for(s=this.e,r=s.length,q=0;q<s.length;s.length===r||(0,A.u)(s),++q){p=s[q]
if(!(p instanceof A.F))p.ci()}},
cA(a){return!1},
bA(){},
cq(){},
cr(){var s,r,q,p
if(this.ax)return
this.cq()
s=A.a1(this.e,t.h)
r=s.length
q=0
for(;q<s.length;s.length===r||(0,A.u)(s),++q){p=s[q]
if(p instanceof A.F)continue
p.cr()}},
cn(){var s,r,q,p,o,n=this
n.bA()
n.v(A.il(n.r))
s=A.a1(n.e,t.h)
r=s.length
q=!1
p=0
for(;p<s.length;s.length===r||(0,A.u)(s),++p){o=s[p]
if(o instanceof A.F)continue
if(o.cn())q=!0}return q}}
A.f9.prototype={
$1(a){var s
t.O.a(a)
s=this.a
if(s.ch)return
this.b.$0()
s.at=null
s.ae()},
$S:35};(function aliases(){var s=J.aO.prototype
s.dg=s.i
s=A.q.prototype
s.dh=s.aV
s=A.cz.prototype
s.di=s.aD
s=A.i.prototype
s.dj=s.ek
s=A.aE.prototype
s.dk=s.dd
s=A.B.prototype
s.dl=s.ah
s.dm=s.bR})();(function installTearOffs(){var s=hunkHelpers._static_2,r=hunkHelpers._static_0,q=hunkHelpers._static_1,p=hunkHelpers._instance_1u,o=hunkHelpers._instance_2u
s(J,"lg","jP",36)
r(A,"lt","jV",11)
q(A,"lM","ke",4)
q(A,"lN","kf",4)
q(A,"lO","kg",4)
r(A,"j1","lD",0)
q(A,"lR","kO",7)
p(A.cr.prototype,"gbB","bC",10)
p(A.cn.prototype,"gbB","bC",10)
o(A.df.prototype,"geJ","eK",15)
r(A,"mc","lz",0)
q(A,"hF","kV",25)})();(function inheritance(){var s=hunkHelpers.mixin,r=hunkHelpers.inherit,q=hunkHelpers.inheritMany
r(A.w,null)
q(A.w,[A.h9,J.d9,A.co,J.c1,A.A,A.q,A.eK,A.h,A.av,A.cv,A.cp,A.V,A.b7,A.aa,A.br,A.aL,A.eN,A.eA,A.c5,A.cN,A.bx,A.eu,A.b4,A.cd,A.fe,A.fE,A.ag,A.ea,A.eg,A.cO,A.cE,A.a6,A.cF,A.bd,A.C,A.e8,A.ee,A.cU,A.bz,A.ec,A.bf,A.d5,A.d3,A.fv,A.aM,A.aN,A.ff,A.dq,A.cq,A.fg,A.N,A.ef,A.eL,A.by,A.Y,A.ez,A.b1,A.aQ,A.eT,A.df,A.J,A.j,A.o,A.r,A.G,A.dU,A.f3,A.fG,A.eh,A.ei,A.W,A.eY,A.bb,A.cy,A.Q,A.f6,A.eb,A.fs,A.ap])
q(J.d9,[J.c7,J.c9,J.ca,J.bt,J.bu,J.bs,J.b3])
q(J.ca,[J.aO,J.p,A.b5,A.cg])
q(J.aO,[J.dr,J.bB,J.at])
r(J.da,A.co)
r(J.er,J.p)
q(J.bs,[J.c8,J.db])
q(A.A,[A.bv,A.az,A.dc,A.dD,A.dx,A.e9,A.cc,A.d_,A.am,A.cu,A.dC,A.bA,A.d4])
r(A.bC,A.q)
r(A.c2,A.bC)
q(A.h,[A.k,A.aB,A.b6,A.dw])
q(A.k,[A.ao,A.ev,A.ce])
q(A.ao,[A.cs,A.aw])
r(A.c4,A.b6)
q(A.aa,[A.bH,A.bI,A.bJ])
r(A.cL,A.bH)
r(A.bh,A.bI)
r(A.aX,A.bJ)
q(A.br,[A.c3,A.c6])
q(A.aL,[A.d1,A.d2,A.dA,A.fW,A.fY,A.fb,A.fa,A.fH,A.fq,A.fz,A.h0,A.h1,A.eJ,A.ey,A.eI,A.eD,A.eE,A.eF,A.eG,A.eH,A.eU,A.fL,A.f2,A.eZ,A.f_,A.f7,A.fP,A.eW,A.f8,A.eR,A.eS,A.eQ,A.eX,A.f9])
q(A.d1,[A.eB,A.fc,A.fd,A.fB,A.fA,A.eq,A.fh,A.fm,A.fl,A.fj,A.fi,A.fp,A.fo,A.fn,A.fy,A.fO,A.f5])
r(A.cj,A.az)
q(A.dA,[A.dz,A.bq])
r(A.au,A.bx)
r(A.cb,A.au)
q(A.d2,[A.fX,A.fI,A.fQ,A.fr,A.ew,A.fw,A.ex,A.f0,A.f1,A.eP,A.fJ])
q(A.cg,[A.dg,A.T])
q(A.T,[A.cH,A.cJ])
r(A.cI,A.cH)
r(A.cf,A.cI)
r(A.cK,A.cJ)
r(A.a2,A.cK)
q(A.cf,[A.dh,A.di])
q(A.a2,[A.dj,A.dk,A.dl,A.dm,A.dn,A.ch,A.ci])
r(A.cP,A.e9)
r(A.aF,A.cF)
r(A.ed,A.cU)
r(A.cM,A.bz)
r(A.cG,A.cM)
q(A.d5,[A.fC,A.es])
r(A.de,A.cc)
r(A.dd,A.d3)
r(A.fu,A.fv)
r(A.et,A.fC)
q(A.am,[A.cl,A.d8])
q(A.eT,[A.i,A.cw])
q(A.i,[A.cz,A.dN,A.P,A.bc,A.aD,A.a8,A.dZ,A.dJ,A.e5])
q(A.cz,[A.B,A.dE])
q(A.B,[A.cr,A.cC,A.dT,A.dH,A.dY])
r(A.cn,A.cC)
r(A.aE,A.dT)
r(A.dK,A.aE)
r(A.F,A.dK)
r(A.dv,A.dE)
r(A.dV,A.dU)
q(A.dN,[A.dM,A.cA])
r(A.ba,A.dM)
r(A.bE,A.cA)
q(A.P,[A.a9,A.dL,A.e0,A.dI,A.dF,A.dP,A.dQ,A.dR,A.dS,A.aV,A.e1])
q(A.dL,[A.dX,A.e7])
r(A.aU,A.cy)
q(A.a9,[A.dO,A.e6])
r(A.b8,A.bc)
q(A.b8,[A.dG,A.e_])
q(A.dH,[A.cB,A.cD,A.e3,A.e4,A.bG])
r(A.cx,A.dZ)
r(A.dW,A.cx)
r(A.bF,A.ff)
s(A.bC,A.b7)
s(A.cH,A.q)
s(A.cI,A.V)
s(A.cJ,A.q)
s(A.cK,A.V)})()
var v={G:typeof self!="undefined"?self:globalThis,typeUniverse:{eC:new Map(),tR:{},eT:{},tPV:{},sEA:[]},mangledGlobalNames:{a:"int",f:"double",S:"num",z:"String",M:"bool",N:"Null",m:"List",w:"Object",aP:"Map",D:"JSObject"},mangledNames:{},types:["~()","~(a9)","N()","~(@)","~(~())","N(@)","M(ap)","@(@)","~(z,a)","z(a)","~(aV)","a()","~(w?,w?)","N(w,aS)","~(f)","~(ba,a)","~(z,m<aQ>)","~(f,f,j,f)","cw(Q)","~(a,@)","an<~>(a9)","f(a)","N(@,aS)","@(@,z)","z(m<f>)","M(D)","M(aD)","M(a8)","f(f)","~(dB)","N(~())","a(a)","S(S,a)","M(B)","a(B,B)","N(a8)","a(@,@)","@(z)","z(f)"],interceptorsByTag:null,leafTags:null,arrayRti:Symbol("$ti"),rttc:{"2;panel,sizer":(a,b)=>c=>c instanceof A.cL&&a.b(c.a)&&b.b(c.b),"3;dish,height,title":(a,b,c)=>d=>d instanceof A.bh&&a.b(d.a)&&b.b(d.b)&&c.b(d.c),"4;":a=>b=>b instanceof A.aX&&A.m5(a,b.a)}}
A.kB(v.typeUniverse,JSON.parse('{"dr":"aO","bB":"aO","at":"aO","mh":"b5","c7":{"M":[],"x":[]},"c9":{"N":[],"x":[]},"ca":{"D":[]},"aO":{"D":[]},"p":{"m":["1"],"k":["1"],"D":[],"h":["1"]},"da":{"co":[]},"er":{"p":["1"],"m":["1"],"k":["1"],"D":[],"h":["1"]},"c1":{"X":["1"]},"bs":{"f":[],"S":[],"a_":["S"]},"c8":{"f":[],"a":[],"S":[],"a_":["S"],"x":[]},"db":{"f":[],"S":[],"a_":["S"],"x":[]},"b3":{"z":[],"a_":["z"],"i_":[],"x":[]},"bv":{"A":[]},"c2":{"q":["a"],"b7":["a"],"m":["a"],"k":["a"],"h":["a"],"q.E":"a","b7.E":"a"},"k":{"h":["1"]},"ao":{"k":["1"],"h":["1"]},"cs":{"ao":["1"],"k":["1"],"h":["1"],"h.E":"1","ao.E":"1"},"av":{"X":["1"]},"aw":{"ao":["2"],"k":["2"],"h":["2"],"h.E":"2","ao.E":"2"},"aB":{"h":["1"],"h.E":"1"},"cv":{"X":["1"]},"b6":{"h":["1"],"h.E":"1"},"c4":{"b6":["1"],"k":["1"],"h":["1"],"h.E":"1"},"cp":{"X":["1"]},"bC":{"q":["1"],"b7":["1"],"m":["1"],"k":["1"],"h":["1"]},"cL":{"bH":[],"aa":[]},"bh":{"bI":[],"aa":[]},"aX":{"bJ":[],"aa":[]},"br":{"aP":["1","2"]},"c3":{"br":["1","2"],"aP":["1","2"]},"c6":{"br":["1","2"],"aP":["1","2"]},"cj":{"az":[],"A":[]},"dc":{"A":[]},"dD":{"A":[]},"cN":{"aS":[]},"aL":{"b2":[]},"d1":{"b2":[]},"d2":{"b2":[]},"dA":{"b2":[]},"dz":{"b2":[]},"bq":{"b2":[]},"dx":{"A":[]},"au":{"bx":["1","2"],"hb":["1","2"],"aP":["1","2"]},"ev":{"k":["1"],"h":["1"],"h.E":"1"},"b4":{"X":["1"]},"ce":{"k":["1"],"h":["1"],"h.E":"1"},"cd":{"X":["1"]},"cb":{"au":["1","2"],"bx":["1","2"],"hb":["1","2"],"aP":["1","2"]},"bH":{"aa":[]},"bI":{"aa":[]},"bJ":{"aa":[]},"b5":{"D":[],"x":[]},"cg":{"D":[]},"dg":{"D":[],"x":[]},"T":{"a0":["1"],"D":[]},"cf":{"q":["f"],"T":["f"],"m":["f"],"a0":["f"],"k":["f"],"D":[],"h":["f"],"V":["f"]},"a2":{"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"]},"dh":{"q":["f"],"T":["f"],"m":["f"],"a0":["f"],"k":["f"],"D":[],"h":["f"],"V":["f"],"x":[],"q.E":"f"},"di":{"q":["f"],"T":["f"],"m":["f"],"a0":["f"],"k":["f"],"D":[],"h":["f"],"V":["f"],"x":[],"q.E":"f"},"dj":{"a2":[],"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"],"x":[],"q.E":"a"},"dk":{"a2":[],"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"],"x":[],"q.E":"a"},"dl":{"a2":[],"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"],"x":[],"q.E":"a"},"dm":{"a2":[],"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"],"x":[],"q.E":"a"},"dn":{"a2":[],"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"],"x":[],"q.E":"a"},"ch":{"a2":[],"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"],"x":[],"q.E":"a"},"ci":{"a2":[],"ct":[],"q":["a"],"T":["a"],"m":["a"],"a0":["a"],"k":["a"],"D":[],"h":["a"],"V":["a"],"x":[],"q.E":"a"},"e9":{"A":[]},"cP":{"az":[],"A":[]},"cO":{"dB":[]},"cE":{"ep":["1"]},"a6":{"A":[]},"cF":{"ep":["1"]},"aF":{"cF":["1"],"ep":["1"]},"C":{"an":["1"]},"cU":{"is":[]},"ed":{"cU":[],"is":[]},"cG":{"bz":["1"],"hg":["1"],"k":["1"],"h":["1"]},"bf":{"X":["1"]},"q":{"m":["1"],"k":["1"],"h":["1"]},"bx":{"aP":["1","2"]},"bz":{"hg":["1"],"k":["1"],"h":["1"]},"cM":{"bz":["1"],"hg":["1"],"k":["1"],"h":["1"]},"cc":{"A":[]},"de":{"A":[]},"dd":{"d3":["w?","z"]},"aM":{"a_":["aM"]},"f":{"S":[],"a_":["S"]},"aN":{"a_":["aN"]},"a":{"S":[],"a_":["S"]},"m":{"k":["1"],"h":["1"]},"S":{"a_":["S"]},"z":{"a_":["z"],"i_":[]},"d_":{"A":[]},"az":{"A":[]},"am":{"A":[]},"cl":{"A":[]},"d8":{"A":[]},"cu":{"A":[]},"dC":{"A":[]},"bA":{"A":[]},"d4":{"A":[]},"dq":{"A":[]},"cq":{"A":[]},"ef":{"aS":[]},"dw":{"h":["a"],"h.E":"a"},"by":{"X":["a"]},"Y":{"k3":[]},"cr":{"B":[],"i":[]},"cn":{"cC":[],"B":[],"i":[]},"F":{"aE":[],"B":[],"i":[]},"dv":{"i":[]},"ka":{"i":[]},"ba":{"i":[]},"a9":{"P":[],"i":[]},"aV":{"P":[],"i":[]},"aD":{"i":[]},"a8":{"i":[]},"b8":{"bc":[],"i":[]},"dY":{"B":[],"i":[]},"aE":{"B":[],"i":[]},"B":{"i":[]},"dV":{"dU":[]},"bE":{"cA":[],"i":[]},"P":{"i":[]},"dL":{"P":[],"i":[]},"dX":{"P":[],"i":[]},"e7":{"P":[],"i":[]},"e0":{"P":[],"i":[]},"dI":{"P":[],"i":[]},"dF":{"P":[],"i":[]},"aU":{"cy":[]},"cz":{"i":[]},"dO":{"a9":[],"P":[],"i":[]},"dP":{"P":[],"i":[]},"dQ":{"P":[],"i":[]},"dR":{"P":[],"i":[]},"dS":{"P":[],"i":[]},"e1":{"P":[],"i":[]},"e6":{"a9":[],"P":[],"i":[]},"dG":{"b8":[],"bc":[],"i":[]},"e_":{"b8":[],"bc":[],"i":[]},"dH":{"B":[],"i":[]},"cB":{"B":[],"i":[]},"cD":{"B":[],"i":[]},"e3":{"B":[],"i":[]},"e4":{"B":[],"i":[]},"bG":{"B":[],"i":[]},"dE":{"i":[]},"dZ":{"i":[]},"cx":{"i":[]},"dW":{"cx":[],"i":[]},"dJ":{"i":[]},"dN":{"i":[]},"dM":{"i":[]},"cA":{"i":[]},"e5":{"i":[]},"bc":{"i":[]},"dK":{"aE":[],"B":[],"i":[]},"cC":{"B":[],"i":[]},"dT":{"B":[],"i":[]},"jK":{"m":["a"],"k":["a"],"h":["a"]},"ct":{"m":["a"],"k":["a"],"h":["a"]},"k7":{"m":["a"],"k":["a"],"h":["a"]},"jI":{"m":["a"],"k":["a"],"h":["a"]},"k5":{"m":["a"],"k":["a"],"h":["a"]},"jJ":{"m":["a"],"k":["a"],"h":["a"]},"k6":{"m":["a"],"k":["a"],"h":["a"]},"jF":{"m":["f"],"k":["f"],"h":["f"]},"jG":{"m":["f"],"k":["f"],"h":["f"]}}'))
A.kA(v.typeUniverse,JSON.parse('{"bC":1,"T":1,"cM":1,"d5":2}'))
var u={c:"Error handler must accept one Object or one Object and a StackTrace as arguments, and return a value of the returned future's type"}
var t=(function rtii(){var s=A.as
return{n:s("a6"),V:s("c2"),r:s("a_<@>"),A:s("aM"),B:s("aN"),G:s("k<@>"),C:s("A"),Z:s("b2"),hf:s("h<@>"),Y:s("h<a>"),gL:s("p<m<a>>"),f:s("p<w>"),g4:s("p<+dish,height,title(b1?,f,z?)>"),eR:s("p<+(eb,f,f,f,f)>"),s:s("p<z>"),y:s("p<cy>"),ct:s("p<ka>"),b:s("p<r>"),J:s("p<ap>"),az:s("p<aD>"),e:s("p<B>"),eB:s("p<my>"),bJ:s("p<eh>"),q:s("p<ei>"),u:s("p<f>"),gn:s("p<@>"),t:s("p<a>"),T:s("c9"),m:s("D"),g:s("at"),aU:s("a0<@>"),dX:s("m<+dish,height,title(b1?,f,z?)>"),da:s("m<aQ>"),a:s("m<r>"),fD:s("m<ap>"),dg:s("m<f>"),j:s("m<@>"),L:s("m<a>"),eO:s("aP<@,@>"),E:s("a2"),P:s("N"),K:s("w"),gT:s("mi"),bQ:s("+()"),l:s("aS"),N:s("z"),p:s("dB"),dm:s("x"),eK:s("az"),gc:s("ct"),ak:s("bB"),O:s("a8"),U:s("aV"),d:s("ap"),W:s("aD"),h8:s("aE"),h:s("B"),gz:s("aF<ct>"),h5:s("aF<a8>"),fg:s("C<ct>"),hg:s("C<a8>"),_:s("C<@>"),D:s("C<~>"),v:s("M"),al:s("M(w)"),i:s("f"),z:s("@"),fO:s("@()"),w:s("@(w)"),Q:s("@(w,aS)"),S:s("a"),eH:s("an<N>?"),an:s("D?"),X:s("w?"),dk:s("z?"),F:s("bd<@,@>?"),R:s("ec?"),fQ:s("M?"),I:s("f?"),h6:s("a?"),cg:s("S?"),o:s("S"),H:s("~"),M:s("~()"),k:s("~(dB)"),c:s("~(ba,a)"),x:s("~(aV)"),ge:s("~(f)")}})();(function constants(){var s=hunkHelpers.makeConstList
B.O=J.d9.prototype
B.a=J.p.prototype
B.u=J.c7.prototype
B.c=J.c8.prototype
B.b=J.bs.prototype
B.f=J.b3.prototype
B.P=J.at.prototype
B.Q=J.ca.prototype
B.n=A.ci.prototype
B.x=J.dr.prototype
B.o=J.bB.prototype
B.r=function getTagFallback(o) {
  var s = Object.prototype.toString.call(o);
  return s.substring(8, s.length - 1);
}
B.E=function() {
  var toStringFunction = Object.prototype.toString;
  function getTag(o) {
    var s = toStringFunction.call(o);
    return s.substring(8, s.length - 1);
  }
  function getUnknownTag(object, tag) {
    if (/^HTML[A-Z].*Element$/.test(tag)) {
      var name = toStringFunction.call(object);
      if (name == "[object Object]") return null;
      return "HTMLElement";
    }
  }
  function getUnknownTagGenericBrowser(object, tag) {
    if (object instanceof HTMLElement) return "HTMLElement";
    return getUnknownTag(object, tag);
  }
  function prototypeForTag(tag) {
    if (typeof window == "undefined") return null;
    if (typeof window[tag] == "undefined") return null;
    var constructor = window[tag];
    if (typeof constructor != "function") return null;
    return constructor.prototype;
  }
  function discriminator(tag) { return null; }
  var isBrowser = typeof HTMLElement == "function";
  return {
    getTag: getTag,
    getUnknownTag: isBrowser ? getUnknownTagGenericBrowser : getUnknownTag,
    prototypeForTag: prototypeForTag,
    discriminator: discriminator };
}
B.J=function(getTagFallback) {
  return function(hooks) {
    if (typeof navigator != "object") return hooks;
    var userAgent = navigator.userAgent;
    if (typeof userAgent != "string") return hooks;
    if (userAgent.indexOf("DumpRenderTree") >= 0) return hooks;
    if (userAgent.indexOf("Chrome") >= 0) {
      function confirm(p) {
        return typeof window == "object" && window[p] && window[p].name == p;
      }
      if (confirm("Window") && confirm("HTMLElement")) return hooks;
    }
    hooks.getTag = getTagFallback;
  };
}
B.F=function(hooks) {
  if (typeof dartExperimentalFixupGetTag != "function") return hooks;
  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);
}
B.I=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Firefox") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "GeoGeolocation": "Geolocation",
    "Location": "!Location",
    "WorkerMessageEvent": "MessageEvent",
    "XMLDocument": "!Document"};
  function getTagFirefox(o) {
    var tag = getTag(o);
    return quickMap[tag] || tag;
  }
  hooks.getTag = getTagFirefox;
}
B.H=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Trident/") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "HTMLDDElement": "HTMLElement",
    "HTMLDTElement": "HTMLElement",
    "HTMLPhraseElement": "HTMLElement",
    "Position": "Geoposition"
  };
  function getTagIE(o) {
    var tag = getTag(o);
    var newTag = quickMap[tag];
    if (newTag) return newTag;
    if (tag == "Object") {
      if (window.DataView && (o instanceof window.DataView)) return "DataView";
    }
    return tag;
  }
  function prototypeForTagIE(tag) {
    var constructor = window[tag];
    if (constructor == null) return null;
    return constructor.prototype;
  }
  hooks.getTag = getTagIE;
  hooks.prototypeForTag = prototypeForTagIE;
}
B.G=function(hooks) {
  var getTag = hooks.getTag;
  var prototypeForTag = hooks.prototypeForTag;
  function getTagFixed(o) {
    var tag = getTag(o);
    if (tag == "Document") {
      if (!!o.xmlVersion) return "!Document";
      return "!HTMLDocument";
    }
    return tag;
  }
  function prototypeForTagFixed(tag) {
    if (tag == "Document") return null;
    return prototypeForTag(tag);
  }
  hooks.getTag = getTagFixed;
  hooks.prototypeForTag = prototypeForTagFixed;
}
B.t=function(hooks) { return hooks; }

B.K=new A.dd()
B.l=new A.et()
B.L=new A.dq()
B.i=new A.eK()
B.aL=new A.f3()
B.h=new A.ed()
B.j=new A.ef()
B.M=new A.eh()
B.m=new A.aN(0)
B.N=new A.aN(16e3)
B.R=new A.es(null)
B.aM=s([],t.u)
B.V=s([37,226,227,207,211,10],t.t)
B.Z={Helvetica:0,"Helvetica-Bold":1,"Helvetica-Oblique":2,"Helvetica-BoldOblique":3,"Times-Roman":4,"Times-Bold":5,"Times-Italic":6,"Times-BoldItalic":7,Courier:8,"Courier-Bold":9,"Courier-Oblique":10,"Courier-BoldOblique":11}
B.w=s([278,278,355,556,556,889,667,191,333,333,389,584,278,333,278,278,556,556,556,556,556,556,556,556,556,556,278,278,584,584,584,556,1015,667,667,722,722,667,611,778,722,278,500,667,556,833,722,778,667,778,722,667,611,722,667,944,667,667,611,278,278,278,469,556,333,556,556,500,556,556,278,556,556,222,222,500,222,833,556,556,556,556,333,500,278,556,500,722,500,500,500,334,260,334,584,0,556,0,222,556,333,1000,556,556,333,1000,667,333,1000,0,611,0,0,222,222,333,333,350,556,1000,333,1000,500,333,944,0,500,667,278,333,556,556,556,556,260,556,333,737,370,556,584,333,737,333,400,584,333,333,333,556,537,278,333,333,365,556,834,834,834,611,667,667,667,667,667,667,1000,722,667,667,667,667,278,278,278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,667,611,556,556,556,556,556,556,889,500,556,556,556,556,278,278,278,278,556,556,556,556,556,556,556,584,611,556,556,556,556,500,556,500],t.t)
B.D=new A.W(718,-207,B.w)
B.v=s([278,333,474,556,556,889,722,238,333,333,389,584,278,333,278,278,556,556,556,556,556,556,556,556,556,556,333,333,584,584,584,611,975,722,722,722,722,667,611,778,722,278,556,722,611,833,722,778,667,778,722,667,611,722,667,944,667,667,611,333,278,333,584,556,333,556,611,556,611,556,333,611,611,278,278,556,278,889,611,611,611,611,389,556,333,611,556,778,556,556,500,389,280,389,584,0,556,0,278,556,500,1000,556,556,333,1000,667,333,1000,0,611,0,0,278,278,500,500,350,556,1000,333,1000,556,333,944,0,500,667,278,333,556,556,556,556,280,556,333,737,370,556,584,333,737,333,400,584,333,333,333,611,556,278,333,333,365,556,834,834,834,611,722,722,722,722,722,722,1000,722,667,667,667,667,278,278,278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,667,611,556,556,556,556,556,556,889,556,556,556,556,556,278,278,278,278,611,611,611,611,611,611,611,584,611,611,611,611,611,556,611,556],t.t)
B.aC=new A.W(718,-207,B.v)
B.aF=new A.W(718,-207,B.w)
B.aD=new A.W(718,-207,B.v)
B.W=s([250,333,408,500,500,833,778,180,333,333,500,564,250,333,250,278,500,500,500,500,500,500,500,500,500,500,278,278,564,564,564,444,921,722,667,667,722,611,556,722,722,333,389,722,611,889,722,722,556,722,667,556,611,722,722,944,722,722,611,333,278,333,469,500,333,444,500,444,500,444,333,500,500,278,278,500,278,778,500,500,500,500,333,389,278,500,500,722,500,500,444,480,200,480,541,0,500,0,333,500,444,1000,500,500,333,1000,556,333,889,0,611,0,0,333,333,444,444,350,500,1000,333,980,389,333,722,0,444,722,250,333,500,500,500,500,200,500,333,760,276,500,564,333,760,333,400,564,300,300,333,500,453,250,333,300,310,500,750,750,750,444,722,722,722,722,722,722,889,667,611,611,611,611,333,333,333,333,722,722,722,722,722,722,722,564,722,722,722,722,722,722,556,500,444,444,444,444,444,444,667,444,444,444,444,444,278,278,278,278,500,500,500,500,500,500,500,564,500,500,500,500,500,500,500,500],t.t)
B.aB=new A.W(683,-217,B.W)
B.T=s([250,333,555,500,500,1000,833,278,333,333,500,570,250,333,250,278,500,500,500,500,500,500,500,500,500,500,333,333,570,570,570,500,930,722,667,722,722,667,611,778,778,389,500,778,667,944,722,778,611,778,722,556,667,722,722,1000,722,722,667,333,278,333,581,500,333,500,556,444,556,444,333,500,556,278,333,556,278,833,556,500,556,556,444,389,333,556,500,722,500,500,444,394,220,394,520,0,500,0,333,500,500,1000,500,500,333,1000,556,333,1000,0,667,0,0,333,333,500,500,350,500,1000,333,1000,389,333,722,0,444,722,250,333,500,500,500,500,220,500,333,747,300,500,570,333,747,333,400,570,300,300,333,556,540,250,333,300,330,500,750,750,750,500,722,722,722,722,722,722,1000,722,667,667,667,667,389,389,389,389,722,722,778,778,778,778,778,570,778,722,722,722,722,722,611,556,500,500,500,500,500,500,722,444,444,444,444,444,278,278,278,278,500,556,500,500,500,500,500,570,500,556,556,556,556,500,556,500],t.t)
B.aG=new A.W(683,-217,B.T)
B.U=s([250,333,420,500,500,833,778,214,333,333,500,675,250,333,250,278,500,500,500,500,500,500,500,500,500,500,333,333,675,675,675,500,920,611,611,667,722,611,611,722,722,333,444,667,556,833,667,722,611,722,611,500,556,722,611,833,611,556,556,389,278,389,422,500,333,500,500,444,500,444,278,500,500,278,278,444,278,722,500,500,500,500,389,389,278,500,444,667,444,444,389,400,275,400,541,0,500,0,333,500,556,889,500,500,333,1000,500,333,944,0,556,0,0,333,333,556,556,350,500,889,333,980,389,333,667,0,389,556,250,389,500,500,500,500,275,500,333,760,276,500,675,333,760,333,400,675,300,300,333,500,523,250,333,300,310,500,750,750,750,500,611,611,611,611,611,611,889,667,611,611,611,611,333,333,333,333,722,667,722,722,722,722,722,675,722,722,722,722,722,556,611,500,500,500,500,500,500,500,667,444,444,444,444,444,278,278,278,278,500,500,500,500,500,500,500,675,500,500,500,500,500,444,500,444],t.t)
B.aA=new A.W(683,-217,B.U)
B.S=s([250,389,555,500,500,833,778,278,333,333,500,570,250,333,250,278,500,500,500,500,500,500,500,500,500,500,333,333,570,570,570,500,832,667,667,667,722,667,667,722,778,389,500,667,611,889,722,722,611,722,667,556,611,722,667,889,667,611,611,333,278,333,570,500,333,500,500,444,500,444,333,500,556,278,278,500,278,778,556,500,500,500,389,389,278,556,444,667,500,444,389,348,220,348,570,0,500,0,333,500,500,1000,500,500,333,1000,556,333,944,0,611,0,0,333,333,500,500,350,500,1000,333,1000,389,333,722,0,389,611,250,389,500,500,500,500,220,500,333,747,266,500,606,333,747,333,400,570,300,300,333,576,500,250,333,300,300,500,750,750,750,500,667,667,667,667,667,667,944,667,667,667,667,667,389,389,389,389,722,722,722,722,722,722,722,570,722,722,722,722,722,611,611,500,500,500,500,500,500,500,722,444,444,444,444,444,278,278,278,278,500,556,500,500,500,500,500,570,500,556,556,556,556,444,500,444],t.t)
B.aE=new A.W(683,-217,B.S)
B.k=s([600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,0,600,0,600,600,600,600,600,600,600,600,600,600,600,0,600,0,0,600,600,600,600,600,600,600,600,600,600,600,600,0,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600],t.t)
B.aH=new A.W(629,-157,B.k)
B.aI=new A.W(629,-157,B.k)
B.aJ=new A.W(629,-157,B.k)
B.aK=new A.W(629,-157,B.k)
B.X=new A.c3(B.Z,[B.D,B.aC,B.aF,B.aD,B.aB,B.aG,B.aA,B.aE,B.aH,B.aI,B.aJ,B.aK],A.as("c3<z,W>"))
B.Y=new A.c6([8364,128,8218,130,402,131,8222,132,8230,133,8224,134,8225,135,710,136,8240,137,352,138,8249,139,338,140,381,142,8216,145,8217,146,8220,147,8221,148,8226,149,8211,150,8212,151,732,152,8482,153,353,154,8250,155,339,156,382,158,376,159],A.as("c6<a,a>"))
B.a_=new A.aX([0,0,26,18])
B.a0=new A.aX([24,-6,20,24])
B.a1=new A.aX([42,2,30,16])
B.a2=new A.aX([-20,6,22,14])
B.a3=A.ak("md")
B.a4=A.ak("me")
B.a5=A.ak("jF")
B.a6=A.ak("jG")
B.a7=A.ak("jI")
B.a8=A.ak("jJ")
B.a9=A.ak("jK")
B.aa=A.ak("w")
B.ab=A.ak("k5")
B.ac=A.ak("k6")
B.ad=A.ak("k7")
B.ae=A.ak("ct")
B.af=new A.Q("tapas","M22 10V1h-8v9c0 1.86 1.28 3.41 3 3.86V21h-2v2h6v-2h-2v-7.14c1.72-.45 3-2 3-3.86zm-2-7v3h-4V3h4zm-7.5 8.5A2.5 2.5 0 0 1 10 14H8v9H6v-9H4a2.5 2.5 0 0 1 0-5h2V8H4a2.5 2.5 0 0 1 0-5h2V1h2v2h2a2.5 2.5 0 0 1 0 5H8v1h2a2.5 2.5 0 0 1 2.5 2.5z")
B.p=new A.Q("wine_bar","M6 3v6c0 2.97 2.16 5.43 5 5.91V19H8v2h8v-2h-3v-4.09c2.84-.48 5-2.94 5-5.91V3H6zm10 5H8V5h8v3z")
B.ag=new A.Q("local_drink","m3 2 2.01 18.23C5.13 21.23 5.97 22 7 22h10c1.03 0 1.87-.77 1.99-1.77L21 2H3zm9 17c-1.66 0-3-1.34-3-3 0-2 3-5.4 3-5.4s3 3.4 3 5.4c0 1.66-1.34 3-3 3zm6.33-11H5.67l-.44-4h13.53l-.43 4z")
B.ah=new A.Q("directions","m21.41 10.59-7.99-8c-.78-.78-2.05-.78-2.83 0l-8.01 8c-.78.78-.78 2.05 0 2.83l8.01 8c.78.78 2.05.78 2.83 0l7.99-8c.79-.79.79-2.05 0-2.83zM13.5 14.5V12H10v3H8v-4c0-.55.45-1 1-1h4.5V7.5L17 11l-3.5 3.5z")
B.ai=new A.Q("local_bar","M21 5V3H3v2l8 9v5H6v2h12v-2h-5v-5l8-9zM7.43 7 5.66 5h12.69l-1.78 2H7.43z")
B.aj=new A.Q("picture_as_pdf","M20 2H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-8.5 7.5c0 .83-.67 1.5-1.5 1.5H9v2H7.5V7H10c.83 0 1.5.67 1.5 1.5v1zm5 2c0 .83-.67 1.5-1.5 1.5h-2.5V7H15c.83 0 1.5.67 1.5 1.5v3zm4-3H19v1h1.5V11H19v2h-1.5V7h3v1.5zM9 9.5h1v-1H9v1zM4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm10 5.5h1v-3h-1v3z")
B.ak=new A.Q("coffee","M18.5 3H6c-1.1 0-2 .9-2 2v5.71c0 3.83 2.95 7.18 6.78 7.29 3.96.12 7.22-3.06 7.22-7v-1h.5c1.93 0 3.5-1.57 3.5-3.5S20.43 3 18.5 3zM16 5v3H6V5h10zm2.5 3H18V5h.5c.83 0 1.5.67 1.5 1.5S19.33 8 18.5 8zM4 19h16v2H4v-2z")
B.y=new A.Q("restaurant","M11 9H9V2H7v7H5V2H3v7c0 2.12 1.66 3.84 3.75 3.97V22h2.5v-9.03C11.34 12.84 13 11.12 13 9V2h-2v7zm5-3v8h2.5v8H21V2c-2.76 0-5 2.24-5 4z")
B.al=new A.Q("location_on","M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 0 1 0-5 2.5 2.5 0 0 1 0 5z")
B.z=new A.Q("local_pizza","M12 2C8.43 2 5.23 3.54 3.01 6L12 22l8.99-16C18.78 3.55 15.57 2 12 2zM7 7c0-1.1.9-2 2-2s2 .9 2 2-.9 2-2 2-2-.9-2-2zm5 8c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2z")
B.am=new A.Q("icecream","1;e;m8.79 12.4 3.26 6.22 3.17-6.21c-.11-.08-.21-.16-.3-.25-.84.53-1.85.84-2.92.84s-2.08-.31-2.92-.84c-.09.09-.19.17-.29.24zm-1.96.59A2.995 2.995 0 0 1 4 10a3 3 0 0 1 2.52-2.96C6.75 4.22 9.12 2 12 2s5.25 2.22 5.48 5.04A3 3 0 0 1 20 10c0 1.59-1.24 2.9-2.81 2.99L12.07 23 6.83 12.99z")
B.an=new A.Q("spa","M8.55 12zm10.43-1.61zm-3.49-.76c-.18-2.79-1.31-5.51-3.43-7.63a12.188 12.188 0 0 0-3.55 7.63c1.28.68 2.46 1.56 3.49 2.63 1.03-1.06 2.21-1.94 3.49-2.63zm-6.5 2.65c-.14-.1-.3-.19-.45-.29.15.11.31.19.45.29zm6.42-.25c-.13.09-.27.16-.4.26.13-.1.27-.17.4-.26zM12 15.45C9.85 12.17 6.18 10 2 10c0 5.32 3.36 9.82 8.03 11.49.63.23 1.29.4 1.97.51.68-.12 1.33-.29 1.97-.51C18.64 19.82 22 15.32 22 10c-4.18 0-7.85 2.17-10 5.45z")
B.ao=new A.Q("dinner_dining","M2 19h20l-2 2H4l-2-2zM5 6h1v1H5V6zm0-2h1v1H5V4zm4 0v1H7V4h2zm0 3H7V6h2v1zm-3 8.23c-.36.11-.69.28-1 .47V8h1v7.23zm-2 1.29c-.38.44-.68.93-.84 1.48h16.82c.01-.16.03-.33.03-.5a5.497 5.497 0 0 0-10.58-2.1c-.59-.25-1.24-.4-1.93-.4-.17 0-.33.02-.5.04V8h2c1.03.06 1.9-.96 2-2h10V5H11c-.1-1.05-.97-1.97-2-2H3v1h1v1H3v1h1v1H3v1h1v8.52z")
B.ap=new A.Q("restaurant_menu","m8.1 13.34 2.83-2.83L3.91 3.5a4.008 4.008 0 0 0 0 5.66l4.19 4.18zm6.78-1.81c1.53.71 3.68.21 5.27-1.38 1.91-1.91 2.28-4.65.81-6.12-1.46-1.46-4.2-1.1-6.12.81-1.59 1.59-2.09 3.74-1.38 5.27L3.7 19.87l1.41 1.41L12 14.41l6.88 6.88 1.41-1.41L13.41 13l1.47-1.47z")
B.aq=new A.r(0,0)
B.e=new A.r(-1,-1)
B.ar=new A.o(1,30)
B.as=new A.o(200,220)
B.at=new A.o(20,20)
B.au=new A.o(22,22)
B.av=new A.o(24,24)
B.aw=new A.o(30,1)
B.ax=new A.o(32,32)
B.A=new A.o(760,-1)
B.B=new A.o(-1,220)
B.d=new A.o(-1,-1)
B.q=new A.bF(0,"none")
B.C=new A.bF(1,"spacer")
B.ay=new A.bF(2,"sizer")
B.az=new A.bF(3,"window")})();(function staticFields(){$.ft=null
$.a5=A.d([],t.f)
$.i0=null
$.eC=0
$.dt=A.lt()
$.hR=null
$.hQ=null
$.j4=null
$.j_=null
$.j6=null
$.fT=null
$.fZ=null
$.hB=null
$.fx=A.d([],A.as("p<m<w>?>"))
$.bQ=null
$.cV=null
$.cW=null
$.hu=!1
$.y=B.h
$.bK=A.kh()
$.aI=A.d([],A.as("p<aE>"))
$.hr=!1
$.fR=-10
$.iQ=1
$.hp=A.bw(t.S,t.O)
$.iY=!1
$.cX=A.d([],A.as("p<a8>"))
$.bY=null
$.iR=1
$.E=A.bw(t.S,t.h)
$.kM=null
$.iT=null
$.bR=A.hc(t.h)})();(function lazyInitializers(){var s=hunkHelpers.lazyFinal,r=hunkHelpers.lazy
s($,"mg","jb",()=>A.fU("_$dart_dartClosure"))
s($,"mf","hG",()=>A.fU("_$dart_dartClosure_dartJSInterop"))
s($,"mA","jm",()=>A.d([new J.da()],A.as("p<co>")))
s($,"ml","jc",()=>A.aA(A.eO({
toString:function(){return"$receiver$"}})))
s($,"mm","jd",()=>A.aA(A.eO({$method$:null,
toString:function(){return"$receiver$"}})))
s($,"mn","je",()=>A.aA(A.eO(null)))
s($,"mo","jf",()=>A.aA(function(){var $argumentsExpr$="$arguments$"
try{null.$method$($argumentsExpr$)}catch(q){return q.message}}()))
s($,"mr","ji",()=>A.aA(A.eO(void 0)))
s($,"ms","jj",()=>A.aA(function(){var $argumentsExpr$="$arguments$"
try{(void 0).$method$($argumentsExpr$)}catch(q){return q.message}}()))
s($,"mq","jh",()=>A.aA(A.ig(null)))
s($,"mp","jg",()=>A.aA(function(){try{null.$method$}catch(q){return q.message}}()))
s($,"mu","jl",()=>A.aA(A.ig(void 0)))
s($,"mt","jk",()=>A.aA(function(){try{(void 0).$method$}catch(q){return q.message}}()))
s($,"mx","hI",()=>A.kd())
s($,"mz","el",()=>A.hE(B.aa))
s($,"mj","hH",()=>{A.jY()
return $.eC})
s($,"mK","c_",()=>A.bD(178,74,44,255))
s($,"mJ","hL",()=>A.bD(92,104,52,255))
s($,"mG","bZ",()=>A.bD(48,36,28,255))
s($,"mI","em",()=>A.bD(116,98,84,255))
s($,"mC","jo",()=>A.bD(255,250,241,236))
s($,"mF","hK",()=>{var q=A.as("p<b1>")
return A.d([A.aR("Starters",B.af,A.d([A.v("Bruschetta al pomodoro","Toasted bread with tomatoes, basil and garlic",6.5),A.v("Vitello tonnato","Thinly sliced veal with tuna sauce and capers",12.9),A.v("Burrata","With cherry tomatoes, rocket and olive oil from Apulia",11.5)],q)),A.aR("Pizza",B.z,A.d([A.v("Margherita","Tomatoes, fior di latte, basil",8.9),A.v("Diavola","Tomatoes, mozzarella, spicy salami, chili",11.5),A.v("Quattro Formaggi","Mozzarella, gorgonzola, taleggio, parmigiano",12.5),A.v("Capricciosa","Ham, mushrooms, artichokes, olives",12.9),A.v("Lucia","Our house pizza: burrata, Parma ham, rocket, cherry tomatoes",14.9)],q)),A.aR("Pasta",B.ao,A.d([A.v("Spaghetti Carbonara","Guanciale, egg yolk, pecorino romano, black pepper",12.5),A.v("Penne all'arrabbiata","Tomato sauce with garlic and peperoncino",10.5),A.v("Tagliatelle al rag\xf9","Homemade ribbon pasta with Bolognese-style beef rag\xf9",13.9)],q)),A.aR("Salads",B.an,A.d([A.v("Insalata mista","Leaf salad, tomatoes, cucumber, carrots",7.5),A.v("Caprese","Tomatoes, buffalo mozzarella, basil",10.5),A.v("Insalata Lucia","Rocket, pear, walnuts, gorgonzola",11.9)],q)),A.aR("Ice cream",B.am,A.d([A.v("Stracciatella","Cream ice cream with chocolate flakes",2.2),A.v("Pistacchio","With pistachios from Bronte",2.5),A.v("Limone","Sorbet made from Amalfi lemons",2.2),A.v("Cioccolato","Dark chocolate",2.2),A.v("Fragola","Strawberry",2.2)],q)),A.aR("Coffee",B.ak,A.d([A.v("Espresso","",2.4),A.v("Cappuccino","",3.4),A.v("Caff\xe8 latte","",3.8),A.v("Caff\xe8 corretto","Espresso with a dash of grappa",4.5)],q))],A.as("p<aQ>"))})
s($,"mE","hJ",()=>{var q=A.as("p<b1>")
return A.d([A.aR("Soft drinks",B.ag,A.d([A.v("Acqua naturale","Still water, 0.75 l",5.5),A.v("Acqua frizzante","Sparkling water, 0.75 l",5.5),A.v("Cola","0.33 l",3.5),A.v("Aranciata","Orange soda, 0.33 l",3.5)],q)),A.aR("Red wine",B.p,A.d([A.v("Chianti Classico","Tuscany, Sangiovese, dry \u2013 glass 0.2 l",7.5),A.v("Montepulciano d'Abruzzo","Abruzzo, full and fruity \u2013 glass 0.2 l",6.5),A.v("Primitivo di Manduria","Apulia, full-bodied \u2013 glass 0.2 l",7.9),A.v("Nero d'Avola","Sicily, velvety \u2013 glass 0.2 l",6.9)],q)),A.aR("White wine",B.p,A.d([A.v("Pinot Grigio","Veneto, fresh and light \u2013 glass 0.2 l",6.5),A.v("Vermentino","Sardinia, mineral \u2013 glass 0.2 l",7.2)],q))],A.as("p<aQ>"))})
s($,"mO","jq",()=>A.ij($.cY(),106))
s($,"mR","hM",()=>A.ij($.bp(),100))
s($,"mL","cY",()=>A.bD(0,0,0,255))
s($,"mQ","bp",()=>A.bD(255,255,255,255))
r($,"mw","aK",()=>A.kc(0,0))
r($,"mv","aJ",()=>A.kb(0,0))
s($,"mM","jp",()=>A.ip($.cY(),100,1))
s($,"mP","bo",()=>A.ip($.cY(),106,1))
s($,"mN","h4",()=>A.ah(13,70,90,400))
s($,"mB","jn",()=>A.kK(A.l9(A.m7(),"wxc"),"fontScale",t.i))})();(function nativeSupport(){!function(){var s=function(a){var m={}
m[a]=1
return Object.keys(hunkHelpers.convertToFastObject(m))[0]}
v.getIsolateTag=function(a){return s("___dart_"+a+v.isolateTag)}
var r="___dart_isolate_tags_"
var q=Object[r]||(Object[r]=Object.create(null))
var p="_ZxYxX"
for(var o=0;;o++){var n=s(p+"_"+o+"_")
if(!(n in q)){q[n]=1
v.isolateTag=n
break}}v.dispatchPropertyName=v.getIsolateTag("dispatch_record")}()
hunkHelpers.setOrUpdateInterceptorsByTag({ArrayBuffer:A.b5,SharedArrayBuffer:A.b5,ArrayBufferView:A.cg,DataView:A.dg,Float32Array:A.dh,Float64Array:A.di,Int16Array:A.dj,Int32Array:A.dk,Int8Array:A.dl,Uint16Array:A.dm,Uint32Array:A.dn,Uint8ClampedArray:A.ch,CanvasPixelArray:A.ch,Uint8Array:A.ci})
hunkHelpers.setOrUpdateLeafTags({ArrayBuffer:true,SharedArrayBuffer:true,ArrayBufferView:false,DataView:true,Float32Array:true,Float64Array:true,Int16Array:true,Int32Array:true,Int8Array:true,Uint16Array:true,Uint32Array:true,Uint8ClampedArray:true,CanvasPixelArray:true,Uint8Array:false})
A.T.$nativeSuperclassTag="ArrayBufferView"
A.cH.$nativeSuperclassTag="ArrayBufferView"
A.cI.$nativeSuperclassTag="ArrayBufferView"
A.cf.$nativeSuperclassTag="ArrayBufferView"
A.cJ.$nativeSuperclassTag="ArrayBufferView"
A.cK.$nativeSuperclassTag="ArrayBufferView"
A.a2.$nativeSuperclassTag="ArrayBufferView"})()
Function.prototype.$0=function(){return this()}
Function.prototype.$1=function(a){return this(a)}
Function.prototype.$2=function(a,b){return this(a,b)}
Function.prototype.$3=function(a,b,c){return this(a,b,c)}
Function.prototype.$4=function(a,b,c,d){return this(a,b,c,d)}
Function.prototype.$1$1=function(a){return this(a)}
convertAllToFastObject(w)
convertToFastObject($);(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!="undefined"){a(document.currentScript)
return}var s=document.scripts
function onLoad(b){for(var q=0;q<s.length;++q){s[q].removeEventListener("load",onLoad,false)}a(b.target)}for(var r=0;r<s.length;++r){s[r].addEventListener("load",onLoad,false)}})(function(a){v.currentScript=a
var s=A.m3
if(typeof dartMainRunner==="function"){dartMainRunner(s,[])}else{s([])}})})()
//# sourceMappingURL=main.dart.js.map
