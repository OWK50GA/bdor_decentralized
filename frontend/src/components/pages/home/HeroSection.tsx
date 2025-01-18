import Image from "next/image";
import actualBdor from '../../../../public/actual-bdor-image.png'
import Link from "next/link";

const HeroSection = () => {
    return ( 
        <div>
            <Image src={actualBdor} alt="Ballon d'Or" height={600} width={600} className="w-fit mx-auto"/>
            <div className="flex flex-col items-center justify-center mt-10 gap-5">
                <p className="text-[#FFD700]  font-bold text-7xl">Ballon d'Or 2025</p>
                <p className="font-semibold text-3xl">
                    Vote for football's greatest honour. Recognizing excellence, celebrating brilliance
                </p>

                <Link href={'/candidates'} className="bg-[#FFD700] rounded-full font-bold text-black text-2xl px-6 py-3">
                    Cast Your Vote
                </Link>
            </div>
        </div>
    );
}
 
export default HeroSection;